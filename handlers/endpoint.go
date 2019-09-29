package main

import (
	endpointtest "github.com/RuNpiXelruN/apiGateway-dummy2"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(endpointtest.CorsTest)
}
