# frozen_string_literal: true

require 'jekyll'

# The fastimage gem may not be installed, and that is OK, we will fall back to another method
FASTIMAGE_AVAILABLE = true

begin
  require 'fastimage'
rescue LoadError
  Jekyll.logger.warning '[Images] Could not load fastimage gem, disabling feature (probably due to conda)'
  FASTIMAGE_AVAILABLE = false
end

module PersonalMonkeyPatchingString
  def clean_alttext
    self._clean_alt_text(self)
  end

  def clean_alttext!
    self.gsub!(/"/, '&quot;')
    if self.strip.length.positive? && !(self.end_with?('.') || self.end_with?('!') || self.end_with?('?'))
      self.gsub!(/$/, '. ')
    end
  end

  def _clean_alt_text(x)
    x = self.gsub(/"/, '&quot;')
    if x.strip.length.positive? && !(x.end_with?('.') || x.end_with?('!') || x.end_with?('?'))
      return "#{x}. "
    end
    x
  end
end

class String
  include PersonalMonkeyPatchingString
end


module Gtn
  # Module to handle pre-calculating image dimensions
  # We can then use those dimensions in the HTML to avoid reflow
  module Images
    def self.cache
      @@cache ||= Jekyll::Cache.new('ImageDimensions')
    end

    def self.html_image_dimensions(tuto_dir, url)
      return '' if !FASTIMAGE_AVAILABLE

      (width, height), path = get_image_dimensions(tuto_dir, url)
      return unless width && height

      [
        %(width="#{width}" height=#{height}),
        path
      ]
    end

    def self.get_image_dimensions(tuto_dir, url)
      if (match = url.match(%r{^{{\s*site.baseurl\s*}}/(.*)})) || (match = url.match(/{%\s*link\s*(.*)\s*%}/))
        _get_image_dimensions(match[1].strip)
      elsif !url.match(%r{https?://})
        img_path = File.absolute_path(File.join(tuto_dir, url))
        _get_image_dimensions(img_path) if File.exist?(img_path)
      else
        _get_image_dimensions(img_path)
      end
    end

    def self._get_image_dimensions(path)
      cache.getset(path) do
        [FastImage.size(path), path]
      rescue StandardError
        Jekyll.logger.info "[Images] Could not resolve size of #{path}"
      end
    end
  end

  module Srcset
  end
end

module Jekyll
  # Our modifications to the markdown renderer to process images with figure captions
  class Figurify < Jekyll::Generator
    safe true

    def initialize(config)
      super
      @config = config['figurify'] ||= {}
    end

    def generate(site)
      site.pages
          .each { |page| figurify page, site }
      site.posts.docs
          .each { |post| figurify post, site }
    end

    private

    def picture(baseurl, path, alt)
      sizes = [480, 1600]
      formats = ['jpeg', 'avif', 'webp']
      responsive_path = 'assets/responsive-images'

      puts "Processing #{path} => [#{sizes.join(', ')} | #{formats.join(', ')}]"
      generated = []
      sizes.each{|s|
        formats.each{|f|
          pathhash = Digest::MD5.hexdigest(path).slice(0, 8)
          basename = File.basename(path, '.*')
          # Add path, extension to generated
          generated << ["#{responsive_path}/#{pathhash}/#{basename}-#{s}.#{f}", s, f]
          # Check if it exists, if not, create it.
          if !File.exist?("#{responsive_path}/#{pathhash}/#{basename}-#{s}.#{f}")
            puts "Creating #{responsive_path}/#{pathhash}/#{basename}-#{s}.#{f}"
            FileUtils.mkdir_p("#{responsive_path}/#{pathhash}")
            if f == 'dither.jpeg'
              `convert #{path} -resize #{s} -dither FloydSteinberg -remap pattern:gray50 #{responsive_path}/#{pathhash}/#{basename}-#{s}.#{f}`
            else
              `convert #{path} -resize #{s} #{responsive_path}/#{pathhash}/#{basename}-#{s}.#{f}`
            end
          end
        }
      }
# <picture>
#   <source srcset="photo.avif" type="image/avif" />
#   <source srcset="photo.webp" type="image/webp" />
#   <img src="photo.jpg" alt="photo" />
# </picture>
      # Generate the html:
      html = "<picture>"
      html += generated.map{|path, size, format|
        puts "Adding #{path} => #{size} #{format}"
        "<source srcset=\"#{baseurl}/#{path}\" type=\"image/#{format}\" media=\"(min-width: #{size}px)\" />"
      }.join("")
      html += "<img src=\"#{baseurl}/#{path}\" alt=\"#{alt}\" />"
      html += "</picture>"
      html
    end

    def figurify(page, site)
      num_figure = 0
      return if page.content.nil?

      tuto_dir = File.dirname(page.path)

      page.content = page.content.gsub(/!\[([^\]]*)\]\((.+?)?\)({:(.*)})?/) do
        alt = ::Regexp.last_match(1)
        url = ::Regexp.last_match(2)
        style = ::Regexp.last_match(4)

        dimensions, _actual_path = Gtn::Images.html_image_dimensions(tuto_dir, url)
        picture = %Q(<img src="#{url}"  alt="#{alt}" #{style} #{dimensions} loading="lazy">)
        if _actual_path
          puts "#{_actual_path}"
          picture = picture(site.config['baseurl'], _actual_path, alt)
        end

        alt.clean_alttext!

        %(
        <a href="#{url}" rel="noopener noreferrer">
          #{picture}
        </a>
        ).split("\n").map(&:strip).join
      end
    end

    def figcaption_prefix(page, site)
      fig = 'Figure'
      if page['lang']
        lang = page['lang']
        fig = site.data['lang'][lang]['figure']
      end
      @config['prefix'] || "#{fig} "
    end

  end
end
