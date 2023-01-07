lint: ## to execute a static analysis to lint this code.
	@markdownlint README.md
	@markdownlint DEPLOY.md
	@shellcheck setup.sh >/dev/null 2>&1 && make yamllint || echo "Lint Failed"

build: ## Generate the website from the markdown and configuration files in the directory dist/
	@hugo

clean: ## Cleanup the content of the directory dist/
	@rm -rf dist/*

unit-tests: ## executes (successfully) the Golang unit tests
	@make POST_TITLE='TEST' POST_NAME='this-is-a-test' post
	@make build
	@make clean

markdownlint:
	@markdownlint README.md
	@markdownlint DEPLOY.md

integration-tests: ## executes the golang integration tests
	@hugo
	@sudo ls dist/

post: ## Create a new blog post whose filename and title come from the environment variables POST_TITLE and POST_NAME.
	@rm -rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md 2>/dev/null || true
	@sed -i 's/^title: .*/title: "$(POST_TITLE)"/' content/posts/$(POST_NAME).md

validate: ## should validate the file ./dist/index.html by using the command line Holberton's W3C Validator, but should not fail if the file is not valid: you expect it to be a non-blocking quality indicator.
	/home/john/Desktop/Curso_DevOps/W3C-Validator/w3c_validator.py ./dist/index.html > /dev/null 2>&1 || true;

package: ## Creates a zip archive of the dist dir api binary.
	@make build
	@zip awesome-website.zip dist/index.html

help: ## Display help about all info how to make recipes.
	@cat Makefile | grep '##' | tr -d '##' | head -n -1
