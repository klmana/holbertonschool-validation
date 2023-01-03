build:
	@hugo
clean:
	@rm -rf dist/*
post:
	@rm -rf content/posts/$(POST_NAME).md
	@hugo new posts/$(POST_NAME).md
	@sed -i 's/title: $(POST_NAME) "$(POST_NAME)"/title: "$(POST_TITLE)"/' content/posts/$(POST_NAME).md 
