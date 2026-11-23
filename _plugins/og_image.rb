# frozen_string_literal: true

require "digest"

# The picture a link preview shows -- what KakaoTalk, Slack, X and the like
# put on top when a link is shared (og:image / twitter:image, written by
# jekyll-seo-tag from a page's `image`). Without one, a chat app picks some
# picture off the page (the scroll-to-top cat).
#
#   * a post or directory with a banner (or cover) picture: that picture
#   * one without: a card in the blog's own look -- its title over its bits,
#     as in its page hero (_layouts/og-card.html; one page per post at
#     /og/<name>/)
#   * every other page (home, tags, archives, ...): the blog's own card
#     (/og/site/)
#
# The deploy workflow (.github/workflows/jekyll.yml) photographs each card
# page into assets/og/<name>.png after the build and drops the pages; a
# local `jekyll serve` has the card pages (to look at) but not the pictures.
module OgImage
  PAGES = "og"
  PICTURES = "/assets/og"

  module_function

  def blank?(value)
    value.nil? || value.to_s.strip.empty?
  end

  # `banner: { image: ... }` or `banner: "..."`; a directory's `cover`.
  # A Notion post without a cover is synced as `banner: { image: "" }`.
  def picture_of(doc)
    banner = doc.data["banner"]
    pic = banner.is_a?(Hash) ? banner["image"] : banner
    pic = doc.data["cover"] if blank?(pic)
    blank?(pic) ? nil : pic.to_s
  end

  # ASCII, unique, the same on every build
  def name_for(doc)
    base = Jekyll::Utils.slugify(doc.basename_without_ext, mode: "ascii")[0, 60].to_s.sub(/-+\z/, "")
    hash = Digest::SHA1.hexdigest(doc.url)[0, 6]
    base.empty? ? hash : "#{base}-#{hash}"
  end

  def card(site, name, data)
    page = Jekyll::PageWithoutAFile.new(site, site.source, File.join(PAGES, name), "index.html")
    page.content = ""
    page.data.merge!(data)
    page.data["layout"] = "og-card"
    page.data["sitemap"] = false
    site.pages << page
  end

  def generate(site)
    site.posts.docs.each do |doc|
      next unless blank?(doc.data["image"])

      if (pic = picture_of(doc))
        doc.data["image"] = pic
      else
        name = name_for(doc)
        card(site, name, "og_for" => doc.url)
        doc.data["image"] = "#{PICTURES}/#{name}.png"
      end
    end

    others = site.pages.select { |page| page.html? && blank?(page.data["image"]) }
    card(site, "site", "og_for" => "site")
    others.each { |page| page.data["image"] = "#{PICTURES}/site.png" }
  end
end

# after the posts are read and numbered (_plugins/kind_numbering.rb), before
# any page is rendered
class OgImageGenerator < Jekyll::Generator
  safe true
  priority :low

  def generate(site)
    OgImage.generate(site)
  end
end
