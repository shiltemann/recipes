module Jekyll
  module AssetFilter
    def delete_jsonld(input)
      input.gsub(/<script type="application.*/, '<!-- no jsonld -->').gsub(/^{".*/, '')
    end

    def replace_newline(input)
      input.gsub(/\n/, '<br>')
    end
  end
end

Liquid::Template.register_filter(Jekyll::AssetFilter)
