build: ## Generate the website from the markdown and configuration files in the directory dist/
	@hugo

clean: ## Cleanup the content of the directory dist/
	@rm -rf dist/*

post: ## Create a new blog post whose filename and title come from the environment variables POST_TITLE and POST_NAME.
	@rm -rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md 2>/dev/null || true
	@sed -i 's/^title: .*/title: "$(POST_TITLE)"/' content/posts/$(POST_NAME).md

help: ## Display help about all info how to make recipes.
	cat Makefile | grep '##' | tr -d '##' | head -n -1
