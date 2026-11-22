# frozen_string_literal: true

# Numbers posts within their "[kind]" at build time, so titles never need a
# hand-kept number.
#
#   "[paper] Title"      -> "[paper #12] Title"
#   "[paper #85] Title"  -> "[paper #12] Title"   (an old number is replaced)
#   "[etc 03.] Title"    -> "[etc #4] Title"
#
# Counting follows what the blog shows: published posts only, oldest first.
#   * draft_ files are not posts at all (Jekyll ignores them), so they are
#     never counted -- publishing one shifts the numbers after it.
#   * directories (layout: directory) and posts with `draft: true` are not
#     counted either; a draft:true post keeps its kind without a number.
#
# Each numbered post also gets `kind` ("paper") and `kind_no` (12) in its
# front matter data, for templates and scripts that group by kind.
# Directory boards list their posts by Notion id; the fallback title shown
# for a not-yet-published entry loses its stale number the same way.
module KindNumbering
  TITLE = /\A(\s*)\[([^\]]+)\](.*)\z/m
  # a trailing number: "#85", " #01", " 03.", " 1.2." -- it must follow a
  # space or "#", so a kind such as "CTF2025" keeps its digits
  NUMBER = /(?:\s+#?|\s*#)\d+(?:\.\d+)*\.?\s*\z/

  module_function

  def split(title)
    m = TITLE.match(title.to_s)
    return nil unless m

    kind = m[2].sub(NUMBER, "").strip
    return nil if kind.empty?

    { lead: m[1], kind: kind, rest: m[3] }
  end

  def counted?(doc)
    doc.data["layout"] != "directory" &&
      doc.data["published"] != false &&
      !doc.data["draft"]
  end

  def number(site)
    groups = Hash.new { |h, k| h[k] = [] }

    site.posts.docs.each do |doc|
      parts = split(doc.data["title"])
      next unless parts

      if counted?(doc)
        groups[parts[:kind].downcase] << [doc, parts]
      else
        doc.data["title"] = "#{parts[:lead]}[#{parts[:kind]}]#{parts[:rest]}"
        doc.data["kind"] = parts[:kind]
      end
    end

    groups.each_value do |entries|
      entries.sort_by! { |doc, _| [doc.date, doc.relative_path] }
      entries.each_with_index do |(doc, parts), i|
        doc.data["title"] = "#{parts[:lead]}[#{parts[:kind]} ##{i + 1}]#{parts[:rest]}"
        doc.data["kind"] = parts[:kind]
        doc.data["kind_no"] = i + 1
      end
    end

    renumber_directory_fallbacks(site)
  end

  # directory front matter: sections -> items { id, title }
  def renumber_directory_fallbacks(site)
    by_id = {}
    site.posts.docs.each do |doc|
      id = doc.data["notion_id"]
      by_id[id] = doc if id && counted?(doc)
    end

    site.posts.docs.each do |doc|
      sections = doc.data["directory"]
      next unless sections.is_a?(Array)

      sections.each do |section|
        items = section.is_a?(Hash) ? section["items"] : nil
        next unless items.is_a?(Array)

        items.each do |item|
          next unless item.is_a?(Hash) && item["title"]

          linked = by_id[item["id"]]
          if linked
            item["title"] = linked.data["title"]
          elsif (parts = split(item["title"]))
            item["title"] = "#{parts[:lead]}[#{parts[:kind]}]#{parts[:rest]}"
          end
        end
      end
    end
  end
end

# right after the posts are read, before any generator (pagination, feed,
# SEO) or template sees a title
Jekyll::Hooks.register :site, :post_read do |site|
  KindNumbering.number(site)
end
