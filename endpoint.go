package endpointtest

import (
	"context"

	"github.com/aws/aws-lambda-go/events"
)

// CorsTest func
func CorsTest(ctx context.Context, e events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		Headers: map[string]string{
			"Access-Control-Allow-Origin": "*",
		},
		StatusCode: 200,
		Body:       "Cors Working??",
	}, nil
}
