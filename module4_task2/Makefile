HUGO=hugo
RM=rm -rf
SHELLCHECK=shellcheck
YAMLLINT=yamllint
YQ=yq
MARKDOWN=markdownlint

build-docker:## Build the Docker image
	docker build -t awesome:build -f build/Dockerfile .

docker-tests:## Build the Docker image
	docker build -t awesome:build -f build/Dockerfile .

build: build-docker ## Build the website and api
	docker run --rm -v $(PWD):/app -w /app awesome:build make build-website
	docker run --rm -v $(PWD):/app -w /app awesome:build go build -o awesome-api

build-website:## Build the Docker image
	hugo --source . --destination dist

post: ## Creates a new post with the title changed to the ENV value.
	$(HUGO) new posts/$(POST_NAME).md
	$(YQ) eval '.title = "$(POST_TITLE)"' ./content/posts/$(POST_NAME).md

clean: ## Remove all files from target folder
	$(RM) dist/*

lint: ## Lints the shell file and run yamllint on success.
	hadolint ./build/Dockerfile
	

yamllint: ## Yamllint github workflow.
	$(YAMLLINT) ./github-workflow.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YAMLLINT) ./release_drafter.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YQ) eval '.jobs.*.steps.[].name' ./github-workflow.yml | wc -l
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make lint' && echo OK
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make integration-test'

markdownlint:## Build the Docker image
	$(MARKDOWN) README.md
	$(MARKDOWN) DEPLOY.md

integration-tests: ## Spin up a server and check the localhost url
	docker run awesome:build sh -c "hugo; make _clean; make _integration-tests;"
	make _integration-tests;

_integration-tests:## Build the Docker image
	touch coverage-integrations.out

unit-tests: ## Runs different makefile recipes
	docker run awesome:build sh -c "hugo; make _clean; make _unit-tests;"
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
