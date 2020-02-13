module Fog
  module DNS
    # This class registers models, requests and collections
    class AzureRM < Fog::Service
      requires :tenant_id
      requires :client_id
      requires :client_secret
      requires :subscription_id
      recognizes :environment

      request_path 'fog/azurerm/requests/dns'
      request :create_or_update_zone
      request :delete_zone
      request :check_zone_exists
      request :list_zones
      request :get_zone
      request :create_or_update_record_set
      request :delete_record_set
      request :list_record_sets
      request :get_records_from_record_set
      request :get_record_set
      request :check_record_set_exists

      model_path 'fog/azurerm/models/dns'
      model :zone
      collection :zones
      model :record_set
      collection :record_sets
      model :a_record
      model :cname_record
      
      # This class provides the mock implementation for unit tests.
      class Mock
        def initialize(_options = {})
        end
      end

      # This class provides the actual implementation for service calls.
      class Real
        def initialize(options)
          begin
            require 'azure_mgmt_dns'
          rescue LoadError => e
            retry if require('rubygems')
            raise e.message
          end

          options[:environment] = 'AzureCloud' if options[:environment].nil?

          credentials = Fog::Credentials::AzureRM.get_credentials(options[:tenant_id], options[:client_id], options[:client_secret], options[:environment])
          options[:credentials] = credentials
          telemetry = "fog-azure-rm/#{Fog::AzureRM::VERSION}"
          @dns_client = ::Azure::Dns::Profiles::Latest::Mgmt::Client.new(options)
          @dns_client.add_user_agent_information(telemetry)
          @tenant_id = options[:tenant_id]
          @client_id = options[:client_id]
          @client_secret = options[:client_secret]
          @environment = options[:environment]
          @resources = Fog::Resources::AzureRM.new(
            tenant_id: options[:tenant_id],
            client_id: options[:client_id],
            client_secret: options[:client_secret],
            subscription_id: options[:subscription_id],
            environment: options[:environment]
          )
        end
      end
    end
  end
end
