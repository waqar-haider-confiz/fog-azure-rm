require 'fog/azurerm'
require 'yaml'

########################################################################################################################
######################                   Services object required by all actions                  ######################
######################                              Keep it Uncommented!                          ######################
########################################################################################################################

azure_credentials = YAML.load_file(File.expand_path('credentials/azure.yml', __dir__))

resource = Fog::Resources::AzureRM.new(
  tenant_id: azure_credentials['tenant_id'],
  client_id: azure_credentials['client_id'],
  client_secret: azure_credentials['client_secret'],
  subscription_id: azure_credentials['subscription_id'],
  environment: azure_credentials['environment']
)
resource_group_name = "RG-#{current_time}"

begin
  ########################################################################################################################
  ######################                   Check Resource Group Exists?                             ######################
  ########################################################################################################################

  flag = resource.resource_groups.check_resource_group_exists(resource_group_name)
  puts "Resource Group doesn't exist." unless flag

  # ########################################################################################################################
  # ######################                    Create Resource Group                                   ######################
  # ########################################################################################################################

  # tags = { key1: 'value1', key2: 'value2' }

  # resource_group = resource.resource_groups.create(
  #   name: resource_group_name,
  #   location: 'eastus',
  #   tags: tags
  # )
  # puts "Created resource group #{resource_group.name}"

  # ########################################################################################################################
  # ######################           Get All Resource Groups in a Subscription                        ######################
  # ########################################################################################################################

  # resource_groups = resource.resource_groups
  # puts 'List resource groups:'
  # resource_groups.each do |a_resource_group|
  #   puts a_resource_group.name
  # end

  # resource_group = resource_groups.get(resource_group_name)
  # puts "Get resource group: #{resource_group.name}"

  # ########################################################################################################################
  # ######################             Get All Resources in a Resource Group                          ######################
  # ########################################################################################################################

  # resources = resource.azure_resources.list_resources_in_resource_group(resource_group_name)
  # puts 'List resources in resource groups:'
  # resources.each do |a_resource|
  #   puts a_resource.name
  # end

  # ########################################################################################################################
  # ######################                           Destroy Resource Group                           ######################
  # ########################################################################################################################

  # puts "Deleted resource group: #{resource_group.destroy}"
rescue Exception => ex
  puts "hahahahahahaa #{ex.inspect}"
  puts 'Integration Test for resource group is failing'
  # resource_group.destroy unless resource_group.nil?
end
