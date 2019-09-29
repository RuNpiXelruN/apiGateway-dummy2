include .env

BINARIES := $(shell ls ./handlers | xargs)
# BINEXAMPLEALSO := $(addprefix dist/,$(notdir $(wildcard handlers/*)))
PACKAGED_TEMPLATE := packaged-template.yaml
TEMPLATE := template.yaml
STACK_NAME := apiGateway-dummy2

STAGE := "develop"

VARS := Stage=$(STAGE) S3Bucket=$(S3_BUCKET)

setEnvs:  
	export $(shell grep -v '^#' .env)

clean:
	rm -rf ./dist	

build: setEnvs $(BINARIES)

$(BINARIES):
	GOOS=linux GOARCH=amd64 go build -o $(addprefix ./dist/, $@) $(addprefix ./handlers/,$(notdir $@))

package: dist/$(PACKAGED_TEMPLATE)

dist/$(PACKAGED_TEMPLATE): build
	aws cloudformation package --template-file $(TEMPLATE) --s3-bucket $(S3_BUCKET) --output-template-file dist/$(PACKAGED_TEMPLATE)

deploy: dist/$(PACKAGED_TEMPLATE)
	# aws s3 cp swagger.yaml s3://$(S3_BUCKET)/$(STACK_NAME)/swagger.yaml
	aws cloudformation deploy \
		--template-file $(addprefix ./dist/, $(PACKAGED_TEMPLATE)) \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--parameter-override $(VARS)