# Current version: jekyll 4.3.2
# bundle is the apt package ruby-bundler
# To get dependencies: sudo bundle install (before: apt-get install ruby-dev)
serve:
	bundle exec jekyll serve --livereload

install:
	sudo gem install \
		bundle jekyll colorator terminal-table \
		forwardable-extended jekyll-watch
