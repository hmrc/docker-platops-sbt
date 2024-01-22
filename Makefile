SHELL := /usr/bin/env bash
ARTIFACTORY_HOST := "artefacts.tax.service.gov.uk"
tag = $$(cat .sbt-version)
artefact = platops-docker-sbt


build:
	@echo '********** Building docker image ************'
	@docker build --no-cache --build-arg SBT_VERSION=$$(cat .sbt-version) -t ${ARTIFACTORY_HOST}/$(artefact):$(tag) -t ${ARTIFACTORY_HOST}/$(artefact):latest .

authenticate_to_artifactory:
	@docker login --username ${ARTIFACTORY_USERNAME} --password "${ARTIFACTORY_PASSWORD}" ${ARTIFACTORY_HOST

push_image: ## Push the hmrc-jre docker image to artifactory
	@docker push ${ARTIFACTORY_HOST}/$(artefact):$(tag)
	@docker push ${ARTIFACTORY_HOST}/$(artefact):latest

