# frozen_string_literal: true

# Directory boards (layout: directory): worked out once, right after the
# posts are read, for every template that shows a board -- the board page,
# its feed card, its report and its link-preview card:
#
#   section.entries   the section's items that are posts (they carry a
#                     Notion id), without the sub-heading labels
#   page.dir_total    how many posts the board holds, over all its sections
#
# The items are the same objects as in section.items, so the titles that
# _plugins/kind_numbering.rb renumbers show the same in both.
Jekyll::Hooks.register :site, :post_read do |site|
  site.posts.docs.each do |doc|
    sections = doc.data["directory"]
    next unless sections.is_a?(Array)

    total = 0
    sections.each do |section|
      next unless section.is_a?(Hash)

      items = section["items"].is_a?(Array) ? section["items"] : []
      section["entries"] = items.select { |item| item.is_a?(Hash) && item["id"] }
      total += section["entries"].size
    end
    doc.data["dir_total"] = total
  end
end
