Jekyll::Hooks.register :site, :post_write do |site|
  Jekyll.logger.info "Running pagefind"
  # p "#{site.baseurl}"
  # if github_run_id is set, we are running in github actions
  puts "#{ENV}"
  if ENV['GITHUB_RUN_ID']
    p "Running in github actions"
    `npm exec -- pagefind --site _site --output-path _site/pagefind/`
  else
    `npm exec -- pagefind --site _site --output-path _site/recipes/pagefind/`
  end
end
