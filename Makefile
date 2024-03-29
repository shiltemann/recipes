install:
	gem install bundler
	bundle install

preview:
	find _config.yml _plugins | entr -r bundle exec jekyll serve --livereload --destination _site/recipes/

update:
	git pull

clean:
	rm -rf _site
