#!/usr/bin/env ruby
require 'nokogiri'

Jekyll::Hooks.register :pages, :post_render do |page|
  if page.site.config['lang'] === 'pt' && ENV['JEKYLL_ENV'] === 'production'
    if page.output.include? 'Click here if you are not redirected.'
      puts 'fixing pt redirects of page: %{pagedir}%{pagename}' % {pagedir: page.dir, pagename: page.name}
      page.output = page.output.gsub! 'en-US', 'pt'
      page.output = page.output.gsub! 'https://blog.danielpadua.dev/', 'https://blog.danielpadua.dev/pt/'
    end
  end
end
