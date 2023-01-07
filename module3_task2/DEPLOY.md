## What is in the archive and how to unarchive it?
* In the archive "awesome-website.zip" contain the binary file of awesome-api and the dist (distribution) directory
* Run the command:
`unzip awesome-website.zip`
## What are the commands to start and stop the application?
* make build: is for make the build and start the application
* hugo server
* make stop: is for stop the application
* make lint
## How to customize where the application logs are written?
* customize where will be written the logs of the app is on the config.toml
## How to “quickly” verify that the application is running (healthcheck)?
* veriry the health of the application we have to run "make status"
* Check it out on local host [http://localhost:1313]
* lint: ## to execute a static analysis to lint this code.
* @shellcheck setup.sh >/dev/null 2>&1 || echo "Lint Failed"