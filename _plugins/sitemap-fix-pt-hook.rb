#!/usr/bin/env ruby
require 'nokogiri'

Jekyll::Hooks.register :pages, :post_convert do |page|
  if page.site.config['lang'] === 'pt' && ENV['JEKYLL_ENV'] === 'production'
    if page.name === 'sitemap.xml'
      puts 'fixing urls in pt sitemap'
      doc = Nokogiri::XML(page.content)
      doc.css('urlset > url').each do |thing|
        url = thing.at_css('loc').content
        unless url.include? 'https://blog.danielpadua.dev/pt/'
          thing.at_css('loc').content = url.insert(28, '/pt')
        end
      end
      page.content = doc
    end
  end
end
