module ApiStub
  module Models
    module Network
      # Mock class for Express Route Circuit Authorization Model
      class ExpressRouteCircuitAuthorization
        def self.create_express_route_circuit_authorization_response(network_client)
          authorization = '{
            "name": "MicrosoftAuthorization",
            "id": "/subscriptions/{guid}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}",
            "properties": {
              "authorizationKey": "authorization-key",
              "authorizationUseStatus": "Available"
            }
          }'

          express_route_circuit_authorization_mapper = Azure::Network::Profiles::Latest::Mgmt::Models::ExpressRouteCircuitAuthorization.mapper
          network_client.deserialize(express_route_circuit_authorization_mapper, Fog::JSON.decode(authorization), 'result.body')
        end
      end
    end
  end
end
