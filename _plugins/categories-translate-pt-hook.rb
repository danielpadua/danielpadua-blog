#!/usr/bin/env ruby

Jekyll::Hooks.register :pages, :pre_render do |page|
  if page.site.config['lang'] === 'pt'
    if page.dir.include? 'categories'
      dest = page.dir.gsub! 'categories', 'categorias'
      puts 'fixing pt translation category page dir: %{pagedir} to %{destdir}' % {pagedir: page.dir, destdir: dest}
      page.dir = dest
    end
  end
end
