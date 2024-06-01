require 'jekyll'

Jekyll::Hooks.register :site, :after_init do |site|
  # Cache the git facts
  begin
    git_head = File.read(File.join('.git', 'HEAD')).strip.split[1]
    git_head_ref = File.read(File.join('.git', git_head)).strip
  rescue StandardError
    git_head_ref = 'none'
  end

  site.config['git_revision'] = git_head_ref
  site.config['git_revision_short'] = git_head_ref[0..6]
end
