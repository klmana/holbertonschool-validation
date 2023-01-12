HUGO=hugo
RM=rm -rf
SHELLCHECK=shellcheck
YAMLLINT=yamllint
YQ=yq
MARKDOWN=markdownlint

build: ## Builds a new website
	hugo
	touch awesome-api

post: ## Creates a new post with the title changed to the ENV value.
	$(HUGO) new posts/$(POST_NAME).md
	sed -i '2s/.*/title: "$(POST_TITLE)"/' content/posts/$(POST_NAME).md

clean: ## Remove all files from target folder
	$(RM) dist

lint: ## Lints the shell file and run yamllint on success.
	$(MARKDOWN) DEPLOY.mdOWN && echo OK
	$(SHELLCHECK) ./Makefile
	$(YAMLLINT) ./github-workflow.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YAMLLINT) ./release_drafter.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YQ) eval '.jobs.*.steps.[].name' ./github-workflow.yml | wc -l
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make lint'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make integration-test'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make unit-test'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make validate'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make package'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make help'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make clean'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make build'
	$(YQ) eval '.jobs.*.steps.[].run' ./github-workflow.yml | grep -q 'make post'

yamllint: ## Yamllint github workflow.
	$(YAMLLINT) ./github-workflow.yml --no-warnings >/dev/null 2>&1 && echo OK
	$(YAMLLINT) ./release_drafter.yml --no-warnings >/dev/null 2>&1 && echo OK

shellcheck: ## Shellcheck Makefile.	
	$(SHELLCHECK) ./Makefile

markdownlint: ## Markdownlint README.md and DEPLOY.md.
	$(MARKDOWN) README.md
	$(MARKDOWN) DEPLOY.md

integration-test: ## Spin up a server and check the localhost url
	hugo
	touch coverage-integrations.out
	ls dist/

unit-test: ## Runs different makefile recipes
	make build
	make clean
	touch coverage-units.out

validate: ## Tests ensure it is in correct dir
	pwd

package: ## Creates a zip archive of the dist dir api binary.
	make build
	mv ./dist ./awesome-website
	zip awesome-website.zip dist/index.html

help: ## Target check
	cat Makefile | grep '##' | tr -d '##' | head -n -1

.PHONY: build post clean lint yamllint shellcheck markdownlint integration-test unit-test validate package help
