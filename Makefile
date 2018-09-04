install:
	gem install bundler
	bundle install

preview:
	bundle exec jekyll serve

update:
	git pull

clean:
	rm -rf _site
