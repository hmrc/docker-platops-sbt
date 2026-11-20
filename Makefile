SHELL := /usr/bin/env bash
ARTIFACTORY_HOST := "artefacts.tax.service.gov.uk"
tag = $$(cat .sbt-version)
artefact = docker-platops-sbt


build:
	@echo '********** Building docker image ************'
	@docker build --pull --no-cache --build-arg SBT_VERSION=$$(cat .sbt-version) -t ${ARTIFACTORY_HOST}/$(artefact):$(tag) -t ${ARTIFACTORY_HOST}/$(artefact):latest .

authenticate_to_artifactory:
	@docker login --username ${ARTIFACTORY_USERNAME} --password "${ARTIFACTORY_PASSWORD}" ${ARTIFACTORY_HOST}

push_image: ## Push the docker-platops-sbt image to Artifactory
	@docker push ${ARTIFACTORY_HOST}/$(artefact):$(tag)
	@docker push ${ARTIFACTORY_HOST}/$(artefact):latest

