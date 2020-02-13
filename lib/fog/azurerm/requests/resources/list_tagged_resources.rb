module Fog
  module Resources
    class AzureRM
      # This class provides the actual implementation for service calls.
      class Real
        def list_tagged_resources(tag_name, tag_value = nil)
          msg = "Listing Resources with tagname: #{tag_name}"
          Fog::Logger.debug msg
          unless tag_name.nil?
            query_filter = "tagname eq '#{tag_name}' "
            query_filter += tag_value.nil? ? '' : "and tagvalue eq '#{tag_value}'"
            puts "2 #{query_filter.inspect}"
            begin
              resources = @rmc.resources.list(filter: query_filter)
              puts "hehehehehhehe #{resources.inspect}"
            rescue MsRestAzure::AzureOperationError => e
              raise_azure_exception(e, msg)
            end
            resources
          end
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def list_tagged_resources(tag_name, tag_value)
          resources = {
            'value' => [
              {
                'id' => '/subscriptions/########-####-####-####-############/fog-rg',
                'name' => 'your-resource-name',
                'type' => 'providernamespace/resourcetype',
                'location' => 'westus',
                'tags' =>
                  {
                    tag_name => tag_value
                  },
                'plan' =>
                  {
                    'name' => 'free'
                  }
              }
            ]
          }
          result_mapper = Azure::Resources::Profiles::Latest::Mgmt::Models::ResourceListResult.mapper
          @rmc.deserialize(result_mapper, resources, 'result.body').value
        end
      end
    end
  end
end
