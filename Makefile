install:
	gem install bundler
	bundle install

preview:
	bundle exec jekyll serve

clean:
	rm -rf _site
