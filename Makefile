# Current version: jekyll 4.3.2
# Github version: jekyll 3.9.5
# bundle is the apt package ruby-bundler
# To get dependencies: sudo bundle install (before: apt-get install ruby-dev)
# To update the dependencies: bundle update. Sometimes you need to do gem update too.
serve:
	bundle exec jekyll serve --livereload


# Clean all docker images with docker rmi $(docker images -q), docker containers prune, docker images prune
docker-serve:
	docker build -f Dockerfile -t codexsite .
	docker run -p "4000:4000" --volume "$$PWD:/home/jekyll:Z" --network=host --rm -ti codexsite \
	bundle exec jekyll serve --livereload
