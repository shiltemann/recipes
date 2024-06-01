Jekyll::Hooks.register :site, :post_write do |site|
  Jekyll.logger.info "Running pagefind"
  # p "#{site.baseurl}"
  `npm exec -- pagefind --site _site --output-path _site/recipes/pagefind/`
end
