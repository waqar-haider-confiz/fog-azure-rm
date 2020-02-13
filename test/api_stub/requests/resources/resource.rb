module ApiStub
  module Requests
    module Resources
      # Mock class for Tag Requests
      class AzureResource
        def self.azure_resource_response(client)
          body = '{
            "id": "/subscriptions/########-####-####-####-############/resourceGroups/{RESOURCE-GROUP}/providers/Microsoft.Network/{PROVIDER-NAME}/{RESOURCE-NAME}",
            "name": "your-resource-name",
                "type": "providernamespace/resourcetype",
                "location": "westus",
                "tags": {
                "tag_name": "tag_value"
            },
                "plan": {
                "name": "free"
            }
          }'
          result_mapper = Azure::Resources::Profiles::Latest::Mgmt::Models::GenericResource.mapper
          client.deserialize(result_mapper, Fog::JSON.decode(body), 'result.body')
        end

        def self.list_tagged_resources_response(client)
          body = '{
            "value": [ {
              "id": "/subscriptions/########-####-####-####-############/resourceGroups/{RESOURCE-GROUP}/providers/Microsoft.Network/{PROVIDER-NAME}/{RESOURCE-NAME}",
              "name": "your-resource-name",
              "type": "providernamespace/resourcetype",
              "location": "westus",
              "tags": {
              "tag_name": "tag_value"
          },
              "plan": {
              "name": "free"
          }
          } ],
            "nextLink": "https://management.azure.com/subscriptions/########-####-####-####-############/resourcegroups?api-version=2015-01-01&$skiptoken=######"
          }'
          result_mapper = Azure::Resources::Profiles::Latest::Mgmt::Models::ResourceListResult.mapper
          client.deserialize(result_mapper, Fog::JSON.decode(body), 'result.body')
        end

        def self.list_resources_in_resource_group(client)
          body = '{
            "id": "/subscriptions/########-####-####-####-############/resourceGroups/{RESOURCE-GROUP}/providers/Microsoft.Network/{PROVIDER-NAME}/{RESOURCE-NAME}",
            "name": "your-resource-name",
            "type": "providernamespace/resourcetype",
            "location": "westus",
            "tags": {
            "tag_name": "tag_value"
            },
            "plan": {
            "name": "free"
            }
          }'
          result_mapper = Azure::Resources::Profiles::Latest::Mgmt::Models::GenericResource.mapper
          client.deserialize(result_mapper, Fog::JSON.decode(body), 'result.body')
        end
      end
    end
  end
end
