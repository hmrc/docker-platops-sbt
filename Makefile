SHELL := /usr/bin/env bash
ARTIFACTORY_URL := "artefacts.tax.service.gov.uk"
tag = $$(cat .sbt-version)
artefact = platops-docker-sbt


build:
	@echo '********** Building docker image ************'
	@docker build --no-cache --build-arg SBT_VERSION=$$(cat .sbt-version) -t ${ARTIFACTORY_URL}/$(artefact):$(tag) -t ${ARTIFACTORY_URL}/$(artefact):latest .

authenticate_to_artifactory:
	@docker login --username ${ARTIFACTORY_USERNAME} --password "${ARTIFACTORY_PASSWORD}" ${ARTIFACTORY_URL}

push_image: ## Push the hmrc-jre docker image to artifactory
	@docker push ${ARTIFACTORY_URL}/$(artefact):$(tag)
	@docker push ${ARTIFACTORY_URL}/$(artefact):latest

