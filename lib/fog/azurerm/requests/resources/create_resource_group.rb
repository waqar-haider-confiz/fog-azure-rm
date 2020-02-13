module Fog
  module Resources
    class AzureRM
      # This class provides the actual implementation for service calls.
      class Real
        def create_resource_group(name, location, tags)
          msg = "Creating Resource Group: #{name}."
          Fog::Logger.debug msg
          resource_group = Azure::Resources::Profiles::Latest::Mgmt::Models::ResourceGroup.new
          resource_group.location = location
          resource_group.tags = tags
          begin
            resource_group = @rmc.resource_groups.create_or_update(name, resource_group)
          rescue  MsRestAzure::AzureOperationError => e
            raise_azure_exception(e, msg)
          end
          Fog::Logger.debug "Resource Group #{name} created successfully."
          resource_group
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def create_resource_group(name, location)
          resource_group = {
            'location' => location,
            'id' => "/subscriptions/########-####-####-####-############/resourceGroups/#{name}",
            'name' => name,
            'properties' =>
            {
              'provisioningState' => 'Succeeded'
            }
          }
          result_mapper = Azure::Resources::Profiles::Latest::Mgmt::Models::ResourceGroup.mapper
          @rmc.deserialize(result_mapper, resource_group, 'result.body')
        end
      end
    end
  end
end
