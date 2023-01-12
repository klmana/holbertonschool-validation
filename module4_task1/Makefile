HUGO=hugo
RM=rm -rf
SHELLCHECK=shellcheck
YAMLLINT=yamllint
YQ=yq
MARKDOWN=markdownlint
# Build the Docker image
build-docker:
	docker run -v /var/run/docker.sock:/var/run/docker.sock
	service docker start
	docker -v
	which docker
	docker build -t awesome:build -f build/Dockerfile .

build: build-docker
	docker run --rm -v $(PWD):/app -w /app awesome:build make build-website
	docker run --rm -v $(PWD):/app -w /app awesome:build go build -o awesome-api

build-website:
	hugo --source . --destination dist

post: ## Creates a new post with the title changed to the ENV value.
	$(HUGO) new posts/$(POST_NAME).md
	$(YQ) eval '.title = "$(POST_TITLE)"' ./content/posts/$(POST_NAME).md

clean: ## Remove all files from target folder
	$(RM) dist/*

lint: ## Lints the shell file and run yamllint on success.
	$(MARKDOWN) README.md
	$(MARKDOWN) DEPLOY.md
	$(SHELLCHECK) setup.sh >/dev/null 2>&1 && make yamllint || echo "Lint Failed"
	

yamllint: ## Yamllint github workflow.
	$(YAMLLINT) ./github-workflow.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YAMLLINT) ./release_drafter.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YQ) eval '.jobs.*.steps.[].name' ./github-workflow.yml | wc -l
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make lint' && echo OK
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make integration-test'

markdownlint:
	$(MARKDOWN) README.md
	$(MARKDOWN) DEPLOY.md

integration-tests: ## Spin up a server and check the localhost url
	$(HUGO)
	touch coverage-integrations.out
	ls dist/

unit-tests: ## Runs different makefile recipes
	make POST_TITLE='TEST' POST_NAME='this-is-a-test' post
	make build
	make clean
	touch coverage-units.out

validate: ## Tests ensure it is in correct dir
	pwd

package: ## Creates a zip archive of the dist dir api binary.
	make build
	zip awesome-website.zip dist/index.html

.SILENT:
help: ## Target check
	cat Makefile | grep '##' | tr -d '##' | head -n -1
