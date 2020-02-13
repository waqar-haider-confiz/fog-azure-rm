module Fog
  module Resources
    # This class registers models, requests and collections
    class AzureRM < Fog::Service
      requires :tenant_id
      requires :client_id
      requires :client_secret
      requires :subscription_id
      recognizes :environment

      request_path 'fog/azurerm/requests/resources'
      request :create_resource_group
      request :list_resource_groups
      request :delete_resource_group
      request :get_resource_group
      request :check_resource_group_exists
      request :create_deployment
      request :delete_deployment
      request :list_deployments
      request :get_deployment
      request :check_deployment_exists
      request :delete_resource_tag
      request :list_tagged_resources
      request :tag_resource
      request :check_azure_resource_exists
      request :list_resources_in_resource_group

      model_path 'fog/azurerm/models/resources'
      model :resource_group
      collection :resource_groups
      model :deployment
      collection :deployments
      model :dependency
      model :provider
      model :provider_resource_type
      model :azure_resource
      collection :azure_resources

      # This class provides the mock implementation for unit tests.
      class Mock
        def initialize(_options = {})
          begin
            require 'azure_mgmt_resources'
          rescue LoadError => e
            retry if require('rubygems')
            raise e.message
          end
        end
      end

      # This class provides the actual implementation for service calls.
      class Real
        def initialize(options)
          begin
            require 'azure_mgmt_resources'
          rescue LoadError => e
            retry if require('rubygems')
            raise e.message
          end

          options[:environment] = 'AzureCloud' if options[:environment].nil?

          credentials = Fog::Credentials::AzureRM.get_credentials(options[:tenant_id], options[:client_id], options[:client_secret], options[:environment])
          options[:credentials] = credentials

          telemetry = "fog-azure-rm/#{Fog::AzureRM::VERSION}"
          @rmc = ::Azure::Resources::Profiles::Latest::Mgmt::Client.new(options)
          @rmc.add_user_agent_information(telemetry)
        end
      end
    end
  end
end
