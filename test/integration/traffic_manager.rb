require 'fog/azurerm'
require 'yaml'

########################################################################################################################
######################                   Services object required by all actions                  ######################
######################                              Keep it Uncommented!                          ######################
########################################################################################################################

azure_credentials = YAML.load_file(File.expand_path('credentials/azure.yml', __dir__))

resources = Fog::Resources::AzureRM.new(
  tenant_id: azure_credentials['tenant_id'],
  client_id: azure_credentials['client_id'],
  client_secret: azure_credentials['client_secret'],
  subscription_id: azure_credentials['subscription_id']
)

traffic_manager = Fog::TrafficManager::AzureRM.new(
  tenant_id: azure_credentials['tenant_id'],
  client_id: azure_credentials['client_id'],
  client_secret: azure_credentials['client_secret'],
  subscription_id: azure_credentials['subscription_id']
)

########################################################################################################################
######################                                 Prerequisites                              ######################
########################################################################################################################

begin
  resource_group = resources.resource_groups.create(
    name: 'TestRG-TM',
    location: LOCATION
  )

  ########################################################################################################################
  ######################                   Check Traffic Manager Profile Exists?                    ######################
  ########################################################################################################################

  flag = traffic_manager.traffic_manager_profiles.check_traffic_manager_profile_exists('TestRG-TM', 'test-tmp')
  puts "Traffic Manager Profile doesn't exist." unless flag

  ########################################################################################################################
  ######################                         Create Traffic Manager Profile                     ######################
  ########################################################################################################################

  tags = { key1: 'value1', key2: 'value2' }

  traffic_manager_profile = traffic_manager.traffic_manager_profiles.create(
    name: 'test-tmp-maham',
    resource_group: 'TestRG-TM',
    tags: tags,
    traffic_routing_method: 'Performance',
    relative_name: 'testapplication',
    ttl: '30',
    protocol: 'http',
    port: '80',
    path: '/monitorpage.aspx'
  )
  puts "Created traffic manager profile: #{traffic_manager_profile.name}"

  ########################################################################################################################
  ######################                   Check Traffic Manager Endpoint Exists?                   ######################
  ########################################################################################################################

  flag = traffic_manager.traffic_manager_end_points.check_traffic_manager_endpoint_exists('TestRG-TM', 'test-tmp', 'myendpoint', 'externalEndpoints')
  puts "Traffic Manager Endpoint doesn't exist." unless flag

  ########################################################################################################################
  ######################                        Create Traffic Manager Endpoint                    ######################
  ########################################################################################################################

  traffic_manager_end_point = traffic_manager.traffic_manager_end_points.create(
    name: 'myendpoint',
    resource_group: 'TestRG-TM',
    traffic_manager_profile_name: 'test-tmp-maham',
    type: 'externalEndpoints',
    target: 'test-app1.com',
    endpoint_location: 'eastus'
  )
  puts "Created traffic manager endpoint: #{traffic_manager_end_point.name}"

  ########################################################################################################################
  ######################                   Get and Update Traffic Manager Endpoint                ######################
  ########################################################################################################################

  end_point = traffic_manager.traffic_manager_end_points.get('TestRG-TM', 'test-tmp-maham', 'myendpoint', 'externalEndpoints')
  puts "Get traffic manager endpoint: #{end_point.name}"
  end_point.update(
    type: 'externalEndpoints',
    target: 'test-app2.com',
    endpoint_location: 'centralus'
  )
  puts 'Updated traffic manager endpoint'

  ########################################################################################################################
  ######################                   Get and Destroy Traffic Manager Endpoint                ######################
  ########################################################################################################################

  end_point = traffic_manager.traffic_manager_end_points.get('TestRG-TM', 'test-tmp-maham', 'myendpoint', 'externalEndpoints')
  # puts "Deleted traffic manager endpoint: #{end_point.destroy}"

  #######################################################################################################################
  #####################                    Get and Update Traffic Manager Profile                 ######################
  #######################################################################################################################

  traffic_manager_profile = traffic_manager.traffic_manager_profiles.get('TestRG-TM', 'test-tmp-maham')
  puts "Get traffic manager profile: #{traffic_manager_profile.name}"
  traffic_manager_profile.update(traffic_routing_method: 'Weighted',
                                 ttl: '35',
                                 protocol: 'https',
                                 port: '90',
                                 endpoints: [end_point],
                                 path: '/monitorpage1.aspx')
  puts 'Updated traffic manager profile'

  ########################################################################################################################
  ######################                    Get and Destroy Traffic Manager Profile                 ######################
  ########################################################################################################################

  # traffic_manager_profile = traffic_manager.traffic_manager_profiles.get('TestRG-TM', 'test-tmp-maham')
  # puts "Deleted traffic manager profile: #{traffic_manager_profile.destroy}"

  ########################################################################################################################
  ######################                                   CleanUp                                  ######################
  ########################################################################################################################

  resource_group = resources.resource_groups.get('TestRG-TM')
  #resource_group.destroy

  puts 'Integration test for Traffic Manager ran successfully!'
rescue Exception => ex
  puts ex.inspect
  puts 'Integration Test for traffic manager is failing'
  resource_group.destroy unless resource_group.nil?
end
