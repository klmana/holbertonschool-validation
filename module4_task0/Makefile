lint:
	@sudo shellcheck setup.sh >/dev/null 2>&1 || echo "Lint Failed"

build: 
	@sudo docker run --rm -v ${PWD}:/app -v /usr/local/bin/hugo:/usr/local/bin/hugo -w /app golang:1.15.8-buster /usr/local/bin/hugo

clean: 
	@sudo rm -rf dist/*

unit-tests:
	@sudo make POST_TITLE='This is a test' POST_NAME='this-is-a-test' post
	@sudo docker run --rm -v ${PWD}:/app -v /usr/local/bin/hugo:/usr/local/bin/hugo -w /app golang:1.15.8-buster /usr/local/bin/hugo
	@sudo make clean

integration-tests:
	@sudo docker run --rm -v ${PWD}:/app -v /usr/local/bin/hugo:/usr/local/bin/hugo -w /app golang:1.15.8-buster /usr/local/bin/hugo
	@sudo docker run --rm -v ${PWD}:/app -w /app golang:1.15.8-buster ls dist/

post: 
	@sudo echo "Creating post with title $(POST_TITLE) and name $(POST_NAME)"
	@sudo docker run --rm -v ${PWD}:/app -v /usr/local/bin/hugo:/usr/local/bin/hugo -w /app golang:1.15.8-buster /usr/local/bin/hugo new posts/$(POST_NAME).md
	@if [ -f "content/posts/$(POST_NAME).md" ]; then \
		sudo echo "File created successfully"; \
		sudo sed -i "s/^title: .*/title: $(POST_TITLE)/" content/posts/$(POST_NAME).md; \
	else \
		sudo echo "Error: file not created"; \
	fi

package:
	@sudo docker run --rm -v ${PWD}:/app -w /app golang:1.15.8-buster zip awesome-website.zip dist/index.html

help: ## Display help about all info how to make recipes.
	@cat Makefile | grep '##' | tr -d '##' | head -n -1

