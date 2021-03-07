#!/usr/bin/env ruby

Jekyll::Hooks.register :pages, :post_convert do |page|
  if page.site.config['lang'] === 'pt' && ENV['JEKYLL_ENV'] === 'production'
    if page.name === 'robots.txt'
      puts 'fixing urls in pt robots.txt'
      page.content = page.content.gsub! 'https://blog.danielpadua.dev/sitemap.xml', 'https://blog.danielpadua.dev/pt/sitemap.xml'
    end
  end
end
