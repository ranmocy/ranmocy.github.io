require 'hashie'

module Jekyll
  class ExtCategoriesBuilder < Generator

    safe true
    priority :highest

    def generate(site)
      site.config['ext_categories'] = {}
      site.categories.each { |category_name, posts|
        site.config['ext_categories'][category_name] =
          Hashie::Mash.new(
            name: category_name,
            posts: posts,
            size: posts.size,
            motto: site.config['motto'][category_name].to_s
          )
      }

      site.config['grouped_categories'] = site.config['categories_group'].collect { |group|
        Hashie::Mash.new(
          name: group.first,
          categories: group.last.collect { |category_name|
            site.config['ext_categories'][category_name]
          }
        )
      }
    end

  end

  class RenderExtCategories < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      category = context.registers[:site].config['ext_categories'][@text.to_s]
      category && category.motto
    end

  end

  module Motto
    def get_motto(category_name)
      category = @context.registers[:site].config['ext_categories'][category_name.to_s]
      category && category.motto
    end
  end
end

# Liquid::Template.register_tag('ext_categories', Jekyll::RenderExtCategories)
Liquid::Template.register_filter(Jekyll::Motto)