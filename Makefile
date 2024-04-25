# Current version: jekyll 4.3.2
# Github version: jekyll 3.9.5
# bundle is the apt package ruby-bundler
# To get dependencies: sudo bundle install (before: apt-get install ruby-dev)
serve:
	bundle exec jekyll serve --livereload


docker-serve:
	docker build -f Dockerfile -t codexsite .
	docker run -p "4000:4000" --volume "$$PWD:/home/jekyll:Z" --network=host --rm -ti codexsite \
	bundle exec jekyll serve --livereload
