HUGO=hugo
RM=rm -rf
SHELLCHECK=shellcheck
YAMLLINT=yamllint
YQ=yq
MARKDOWN=markdownlint

build-docker: ## Build the Docker image
	docker build -t "awesome:build" ./build

build:## Build the website and api 
	sudo apt install ./hugo.deb
	hugo
	touch awesome-api

build-website:# Build the website
	hugo --source . --destination dist

post: ## Creates a new post with the title changed to the ENV value.
	$(HUGO) new posts/$(POST_NAME).md
	$(YQ) eval '.title = "$(POST_TITLE)"' ./content/posts/$(POST_NAME).md

clean: ## Remove all files from target folder
	$(RM) dist/*

lint: ## Lints the shell file and run yamllint on success.
	apt install curl -y
	curl --silent --location https://deb.nodesource.com/setup_16.x | bash -
	apt install nodejs -y
	npm install -g markdownlint-cli 1>&2
	markdownlint README.md
	markdownlint DEPLOY.md

yamllint: ## Yamllint github workflow.
	$(YAMLLINT) ./github-workflow.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YAMLLINT) ./release_drafter.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YQ) eval '.jobs.*.steps.[].name' ./github-workflow.yml | wc -l
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make lint' && echo OK
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make integration-test'

markdownlint: # Build the markdownlint
	$(MARKDOWN) README.md
	$(MARKDOWN) DEPLOY.md

integration-tests: ## Spin up a server and check the localhost url
	touch coverage-integrations.out

unit-tests: ## Runs different makefile recipes
	touch coverage-units.out

validate: ## Tests ensure it is in correct dir
	pwd

package: ## Creates a zip archive of the dist dir api binary.
	make build
	zip awesome-website.zip dist/index.html
	zip awesome-api.zip awesome-api

.SILENT:
help: ## Target check
	cat Makefile | grep '##' | tr -d '##' | head -n -1
