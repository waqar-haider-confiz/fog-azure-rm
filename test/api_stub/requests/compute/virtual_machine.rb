module ApiStub
  module Requests
    module Compute
      # Mock class for Virtual Machine Requests
      class VirtualMachine
        def self.linux_virtual_machine_params
          {
            resource_group: 'fog-test-rg',
            name: 'fog-test-server',
            location: 'westus',
            vm_size: 'Basic_A0',
            storage_account_name: 'fogstrg',
            username: 'fog',
            password: 'fog',
            disable_password_authentication: false,
            ssh_key_path: '/home',
            ssh_key_data: 'key',
            network_interface_card_id: 'nic-id',
            availability_set_id: 'as-id',
            publisher: 'Canonical',
            offer: 'UbuntuServer',
            sku: '14.04.2-LTS',
            version: 'latest',
            platform: 'Linux',
            provision_vm_agent: nil,
            enable_automatic_updates: nil
          }
        end

        def self.windows_virtual_machine_params
          {
            resource_group: 'fog-test-rg',
            name: 'fog-test-server',
            location: 'westus',
            vm_size: 'Basic_A0',
            storage_account_name: 'fogstrg',
            username: 'fog',
            password: 'fog',
            disable_password_authentication: nil,
            ssh_key_path: '/home',
            ssh_key_data: 'key',
            network_interface_card_id: 'nic-id',
            availability_set_id: 'as-id',
            publisher: 'MicrosoftWindowsServerEssentials',
            offer: 'WindowsServerEssentials',
            sku: 'WindowsServerEssentials',
            version: 'latest',
            platform: 'Windows',
            provision_vm_agent: true,
            enable_automatic_updates: true
          }
        end

        def self.linux_virtual_machine_with_custom_data_params
          {
            resource_group: 'fog-test-rg',
            name: 'fog-test-server',
            location: 'westus',
            vm_size: 'Basic_A0',
            storage_account_name: 'fogstrg',
            username: 'fog',
            password: 'fog',
            disable_password_authentication: false,
            ssh_key_path: '/home',
            ssh_key_data: 'key',
            network_interface_card_id: 'nic-id',
            availability_set_id: 'as-id',
            publisher: 'Canonical',
            offer: 'UbuntuServer',
            sku: '14.04.2-LTS',
            version: 'latest',
            platform: 'Linux',
            provision_vm_agent: nil,
            enable_automatic_updates: nil,
            custom_data: 'echo customData'
          }
        end

        def self.windows_virtual_machine_with_custom_data_params
          {
            resource_group: 'fog-test-rg',
            name: 'fog-test-server',
            location: 'westus',
            vm_size: 'Basic_A0',
            storage_account_name: 'fogstrg',
            username: 'fog',
            password: 'fog',
            disable_password_authentication: nil,
            ssh_key_path: '/home',
            ssh_key_data: 'key',
            network_interface_card_id: 'nic-id',
            availability_set_id: 'as-id',
            publisher: 'MicrosoftWindowsServerEssentials',
            offer: 'WindowsServerEssentials',
            sku: 'WindowsServerEssentials',
            version: 'latest',
            platform: 'Windows',
            provision_vm_agent: true,
            enable_automatic_updates: true,
            custom_data: 'echo customData'
          }
        end

        def self.create_virtual_machine_response(compute_client)
          body = '{
            "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
            "name":"fog-test-server",
            "type":"Microsoft.Compute/virtualMachines",
            "location":"westus",
            "tags": {
              "department":"finance"
            },
            "properties": {
              "availabilitySet": {
                "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
              },
              "hardwareProfile": {
                "vmSize":"Standard_A0"
              },
              "storageProfile": {
                "imageReference": {
                  "publisher":"MicrosoftWindowsServerEssentials",
                  "offer":"WindowsServerEssentials",
                  "sku":"WindowsServerEssentials",
                  "version":"latest"
                },
                "osDisk": {
                  "name":"myosdisk1",
                  "vhd": {
                    "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                  },
                  "caching":"ReadWrite",
                  "createOption":"FromImage"
                },
                "dataDisks": [ {
                   "name":"mydatadisk1",
                   "diskSizeGB":"1",
                   "lun": 0,
                   "vhd": {
                     "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                   },
                   "createOption":"Empty"
                 } ]
              },
              "osProfile": {
                "computerName":"fog-test-server",
                "adminUsername":"fog",
                "adminPassword":"fog",
                "customData":"",
                "windowsConfiguration": {
                  "provisionVMAgent":true,
                  "winRM": {
                    "listeners": [ {
                      "protocol": "https",
                      "certificateUrl": "url-to-certificate"
                    } ]
                  },
                  "enableAutomaticUpdates":true
                },
                "secrets":[ {
                   "sourceVault": {
                     "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                   },
                   "vaultCertificates": [ {
                     "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                     "certificateStore": "{certificateStoreName}"
                   } ]
                 } ]
              },
              "networkProfile": {
                "networkInterfaces": [ {
                  "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                } ]
              }
            }
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.create_virtual_machine_with_custom_data_response(compute_client)
          body = '{
            "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
            "name":"fog-test-server",
            "type":"Microsoft.Compute/virtualMachines",
            "location":"westus",
            "tags": {
              "department":"finance"
            },
            "properties": {
              "availabilitySet": {
                "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
              },
              "hardwareProfile": {
                "vmSize":"Standard_A0"
              },
              "storageProfile": {
                "imageReference": {
                  "publisher":"MicrosoftWindowsServerEssentials",
                  "offer":"WindowsServerEssentials",
                  "sku":"WindowsServerEssentials",
                  "version":"latest"
                },
                "osDisk": {
                  "name":"myosdisk1",
                  "vhd": {
                    "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                  },
                  "caching":"ReadWrite",
                  "createOption":"FromImage"
                },
                "dataDisks": [ {
                   "name":"mydatadisk1",
                   "diskSizeGB":"1",
                   "lun": 0,
                   "vhd": {
                     "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                   },
                   "createOption":"Empty"
                 } ]
              },
              "osProfile": {
                "computerName":"fog-test-server",
                "adminUsername":"fog",
                "adminPassword":"fog",
                "customData":"ZWNobyBjdXN0b21EYXRh",
                "windowsConfiguration": {
                  "provisionVMAgent":true,
                  "winRM": {
                    "listeners": [ {
                      "protocol": "https",
                      "certificateUrl": "url-to-certificate"
                    } ]
                  },
                  "enableAutomaticUpdates":true
                },
                "secrets":[ {
                   "sourceVault": {
                     "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                   },
                   "vaultCertificates": [ {
                     "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                     "certificateStore": "{certificateStoreName}"
                   } ]
                 } ]
              },
              "networkProfile": {
                "networkInterfaces": [ {
                  "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                } ]
              }
            }
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.create_virtual_machine_from_custom_image_response(compute_client)
          body = '{
            "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
            "name":"fog-test-server",
            "type":"Microsoft.Compute/virtualMachines",
            "location":"westus",
            "tags": {
              "department":"finance"
            },
            "properties": {
              "availabilitySet": {
                "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
              },
              "hardwareProfile": {
                "vmSize":"Standard_A0"
              },
              "storageProfile": {
                "imageReference": {
                  "publisher":"",
                  "offer":"",
                  "sku":"",
                  "version":""
                },
                "osDisk": {
                  "name":"myosdisk1",
                  "vhd": {
                    "uri":"https://custimagestorage.blob.core.windows.net/customimage/trusty-server-cloudimg-amd64-disk1.vhd"
                  },
                  "caching":"ReadWrite",
                  "createOption":"FromImage"
                },
                "dataDisks": [ {
                   "name":"mydatadisk1",
                   "diskSizeGB":"1",
                   "lun": 0,
                   "vhd": {
                     "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                   },
                   "createOption":"Empty"
                 } ]
              },
              "osProfile": {
                "computerName":"fog-test-server",
                "adminUsername":"fog",
                "adminPassword":"fog",
                "customData":"",
                "windowsConfiguration": {
                  "provisionVMAgent":true,
                  "winRM": {
                    "listeners": [ {
                      "protocol": "https",
                      "certificateUrl": "url-to-certificate"
                    } ]
                  },
                  "enableAutomaticUpdates":true
                },
                "secrets":[ {
                   "sourceVault": {
                     "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                   },
                   "vaultCertificates": [ {
                     "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                     "certificateStore": "{certificateStoreName}"
                   } ]
                 } ]
              },
              "networkProfile": {
                "networkInterfaces": [ {
                  "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                } ]
              }
            }
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.detach_data_disk_from_vm_response(compute_client)
          body = '{
            "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
            "name":"fog-test-server",
            "type":"Microsoft.Compute/virtualMachines",
            "location":"westus",
            "tags": {
              "department":"finance"
            },
            "properties": {
              "availabilitySet": {
                "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
              },
              "hardwareProfile": {
                "vmSize":"Standard_A0"
              },
              "storageProfile": {
                "imageReference": {
                  "publisher":"MicrosoftWindowsServerEssentials",
                  "offer":"WindowsServerEssentials",
                  "sku":"WindowsServerEssentials",
                  "version":"latest"
                },
                "osDisk": {
                  "name":"myosdisk1",
                  "vhd": {
                    "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                  },
                  "caching":"ReadWrite",
                  "createOption":"FromImage"
                },
                "dataDisks": []
              },
              "osProfile": {
                "computerName":"fog-test-server",
                "adminUsername":"fog",
                "adminPassword":"fog",
                "customData":"",
                "windowsConfiguration": {
                  "provisionVMAgent":true,
                  "winRM": {
                    "listeners": [ {
                      "protocol": "https",
                      "certificateUrl": "url-to-certificate"
                    } ]
                  },
                  "enableAutomaticUpdates":true
                },
                "secrets":[ {
                   "sourceVault": {
                     "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                   },
                   "vaultCertificates": [ {
                     "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                     "certificateStore": "{certificateStoreName}"
                   } ]
                 } ]
              },
              "networkProfile": {
                "networkInterfaces": [ {
                  "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                } ]
              }
            }
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.virtual_machine_response(compute_client)
          body = {
            'location' => 'westus',
            'id' => '/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server',
            'name' => 'fog-test-server',
            'type' => 'Microsoft.Compute/virtualMachines',
            'tags' =>
              {
                'department' => 'finance'
              },
            'properties' =>
              {
                'hardwareProfile' =>
                  {
                    'vmSize' => 'Standard_A0'
                  },
                'storageProfile' =>
                  {
                    'imageReference' =>
                      {
                        'publisher' => 'MicrosoftWindowsServerEssentials',
                        'offer' => 'WindowsServerEssentials',
                        'sku' => 'WindowsServerEssentials',
                        'version' => 'latest'
                      },
                    'osDisk' =>
                      {
                        'name' => 'myosdisk1',
                        'vhd' =>
                          {
                            'uri' => 'http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd'
                          },
                        'createOption' => 'FromImage',
                        'caching' => 'ReadWrite'
                      },
                    'dataDisks' =>
                      [
                        {
                          'lun' => 0,
                          'name' => 'mydatadisk1',
                          'vhd' =>
                            {
                              'uri' => 'http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd'
                            },
                          'createOption' => 'Empty',
                          'diskSizeGB' => 1
                        }
                      ]
                  },
                'osProfile' =>
                  {
                    'computerName' => 'fog-test-server',
                    'adminUsername' => 'fog',
                    'adminPassword' => 'fog',
                    'customData' => '',
                    'windowsConfiguration' =>
                      {
                        'provisionVMAgent' => true,
                        'enableAutomaticUpdates' => true,
                        'winRM' =>
                          {
                            'listeners' =>
                              [
                                {
                                  'protocol' => 'https',
                                  'certificateUrl' => 'url-to-certificate'
                                }
                              ]
                          }
                      },
                    'secrets' =>
                      [
                        {
                          'sourceVault' =>
                            {
                              'id' => '/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1'
                            },
                          'vaultCertificates' =>
                            [
                              {
                                'certificateUrl' => 'https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}',
                                'certificateStore' => '{certificateStoreName}'
                              }
                            ]
                        }
                      ]
                  },
                'networkProfile' =>
                  {
                    'networkInterfaces' =>
                      [
                        {
                          'id' => '/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1'
                        }
                      ]
                  },
                'availabilitySet' =>
                  {
                    'id' => '/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1'
                  }
              }
          }
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, body, 'result.body')
        end

        def self.list_virtual_machines_response(compute_client)
          body = '{
            "value": [
              {
                "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
                "name":"fog-test-server",
                "type":"Microsoft.Compute/virtualMachines",
                "location":"westus",
                "tags": {
                  "department":"finance"
                },
                "properties": {
                  "availabilitySet": {
                    "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
                  },
                  "hardwareProfile": {
                    "vmSize":"Standard_A0"
                  },
                  "storageProfile": {
                    "imageReference": {
                      "publisher":"MicrosoftWindowsServerEssentials",
                      "offer":"WindowsServerEssentials",
                      "sku":"WindowsServerEssentials",
                      "version":"latest"
                    },
                    "osDisk": {
                      "name":"myosdisk1",
                      "vhd": {
                        "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                      },
                      "caching":"ReadWrite",
                      "createOption":"FromImage"
                    },
                    "dataDisks": [ {
                       "name":"mydatadisk1",
                       "diskSizeGB":"1",
                       "lun": 0,
                       "vhd": {
                         "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                       },
                       "createOption":"Empty"
                     } ]
                  },
                  "osProfile": {
                    "computerName":"fog-test-server",
                    "adminUsername":"fog",
                    "adminPassword":"fog",
                    "customData":"",
                    "windowsConfiguration": {
                      "provisionVMAgent":true,
                      "winRM": {
                        "listeners": [ {
                          "protocol": "https",
                          "certificateUrl": "url-to-certificate"
                        } ]
                      },
                      "enableAutomaticUpdates":true
                    },
                    "secrets":[ {
                       "sourceVault": {
                         "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                       },
                       "vaultCertificates": [ {
                         "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                         "certificateStore": "{certificateStoreName}"
                       } ]
                     } ]
                  },
                  "networkProfile": {
                    "networkInterfaces": [ {
                      "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                    } ]
                  }
                }
              }
            ]
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachineListResult.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.list_available_sizes_for_virtual_machine_response(compute_client)
          body = '{
            "value": [
              {
                "name": "Standard_A0",
                "numberOfCores": 1,
                "osDiskSizeInMB": 130048,
                "resourceDiskSizeInMB": 20480,
                "memoryInMB": 768,
                "maxDataDiskCount": 1
              }
            ]
          }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachineSizeListResult.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.virtual_machine_instance_view_response(compute_client)
          body = '{
            "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
            "name":"fog-test-server",
            "type":"Microsoft.Compute/virtualMachines",
            "location":"westus",
            "tags": {
              "department":"finance"
            },
            "properties":
              {
                "instanceView":
                  {
                    "platformUpdateDomain": 0,
                    "platformFaultDomain": 0,
                    "vmAgent":
                      {
                        "vmAgentVersion": "2.5.1198.709",
                        "statuses": [
                          {
                            "code": "ProvisioningState/succeeded",
                            "level": "Info",
                            "displayStatus": "Ready",
                            "message": "GuestAgent is running and accepting new configurations.",
                            "time": "2015-04-21T11:42:44-07:00"
                          }]
                      },
                    "disks": [
                      {
                        "name": "msvm-os-20150410-074408-487548",
                        "statuses": [
                          {
                            "code": "ProvisioningState/succeeded",
                            "level": "Info",
                            "displayStatus": "Provisioning succeeded",
                            "time": "2015-04-10T12:44:10.4562812-07:00"
                          }]
                      }],
                    "statuses": [
                      {
                        "code": "ProvisioningState/succeeded",
                        "level": "Info",
                        "displayStatus": "Provisioning succeeded",
                        "time": "2015-04-10T12:50:09.0031588-07:00"
                      },
                      {
                        "code": "PowerState/running",
                        "level": "Info",
                        "displayStatus": "VM running"
                      }]
                  }
              }
            }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.vm_status_response
          'running'
        end

        def self.update_virtual_machine_response(compute_client)
          body = '
          {
                "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
                "name":"fog-test-server",
                "type":"Microsoft.Compute/virtualMachines",
                "location":"westus",
                "tags": {
                  "department":"finance"
                },
                "properties": {
                  "availabilitySet": {
                    "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
                  },
                  "hardwareProfile": {
                    "vmSize":"Standard_A0"
                  },
                  "storageProfile": {
                    "imageReference": {
                      "publisher":"MicrosoftWindowsServerEssentials",
                      "offer":"WindowsServerEssentials",
                      "sku":"WindowsServerEssentials",
                      "version":"latest"
                    },
                    "osDisk": {
                      "name":"myosdisk1",
                      "vhd": {
                        "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                      },
                      "caching":"ReadWrite",
                      "createOption":"FromImage"
                    },
                    "dataDisks": [ {
                       "name":"mydatadisk1",
                       "diskSizeGB":"1",
                       "lun": 0,
                       "vhd": {
                         "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                       },
                       "createOption":"Empty"
                     },
                    {
                      "name":"disk1",
                       "diskSizeGB":"1",
                       "lun": 0,
                       "vhd": {
                         "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                       },
                       "createOption":"Empty"
                    }]
                  },
                  "osProfile": {
                    "computerName":"fog-test-server",
                    "adminUsername":"fog",
                    "adminPassword":"fog",
                    "customData":"",
                    "windowsConfiguration": {
                      "provisionVMAgent":true,
                      "winRM": {
                        "listeners": [ {
                          "protocol": "https",
                          "certificateUrl": "url-to-certificate"
                        } ]
                      },
                      "enableAutomaticUpdates":true
                    },
                    "secrets":[ {
                       "sourceVault": {
                         "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                       },
                       "vaultCertificates": [ {
                         "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                         "certificateStore": "{certificateStoreName}"
                       } ]
                     } ]
                  },
                  "networkProfile": {
                    "networkInterfaces": [ {
                      "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                    } ]
                  }
                }
              }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end

        def self.virtual_machine_15_data_disks_response(compute_client)
          body = '
          {
                "id":"/subscriptions/{subscription-id}/resourceGroups/fog-test-rg/providers/Microsoft.Compute/virtualMachines/fog-test-server",
                "name":"fog-test-server",
                "type":"Microsoft.Compute/virtualMachines",
                "location":"westus",
                "tags": {
                  "department":"finance"
                },
                "properties": {
                  "availabilitySet": {
                    "id":"/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.Compute/availabilitySets/myav1"
                  },
                  "hardwareProfile": {
                    "vmSize":"Standard_A0"
                  },
                  "storageProfile": {
                    "imageReference": {
                      "publisher":"MicrosoftWindowsServerEssentials",
                      "offer":"WindowsServerEssentials",
                      "sku":"WindowsServerEssentials",
                      "version":"latest"
                    },
                    "osDisk": {
                      "name":"myosdisk1",
                      "vhd": {
                        "uri":"http://mystorage1.blob.core.windows.net/vhds/myosdisk1.vhd"
                      },
                      "caching":"ReadWrite",
                      "createOption":"FromImage"
                    },
                    "dataDisks": [ {
                       "name":"mydatadisk1",
                       "diskSizeGB":"1",
                       "lun": 0,
                       "vhd": {
                         "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                       },
                       "createOption":"Empty"
                     },
                    {
                      "name":"disk1",
                       "diskSizeGB":"1",
                       "lun": 1,
                       "vhd": {
                         "uri" : "http://mystorage1.blob.core.windows.net/vhds/mydatadisk1.vhd"
                       },
                       "createOption":"Empty"
                    },
                    {
                      "name":"disk2",
                      "lun": 2
                    },
                    {
                      "name":"disk3",
                      "lun": 3
                    },
                    {
                      "name":"disk3",
                      "lun": 4
                    },
                    {
                      "name":"disk4",
                      "lun": 5
                    },
                    {
                      "name":"disk5",
                      "lun": 6
                    },
                    {
                      "name":"disk6",
                      "lun": 7
                    },
                    {
                      "name":"disk7",
                      "lun": 8
                    },
                    {
                      "name":"disk8",
                      "lun": 9
                    },
                    {
                      "name":"disk9",
                      "lun": 10
                    },
                    {
                      "name":"disk10",
                      "lun": 11
                    },
                    {
                      "name":"disk11",
                      "lun": 12
                    },
                    {
                      "name":"disk12",
                      "lun": 13
                    },
                    {
                      "name":"disk13",
                      "lun": 14
                    },
                    {
                      "name":"disk14",
                      "lun": 15
                    }]
                  },
                  "osProfile": {
                    "computerName":"fog-test-server",
                    "adminUsername":"fog",
                    "adminPassword":"fog",
                    "customData":"",
                    "windowsConfiguration": {
                      "provisionVMAgent":true,
                      "winRM": {
                        "listeners": [ {
                          "protocol": "https",
                          "certificateUrl": "url-to-certificate"
                        } ]
                      },
                      "enableAutomaticUpdates":true
                    },
                    "secrets":[ {
                       "sourceVault": {
                         "id": "/subscriptions/{subscription-id}/resourceGroups/myresourcegroup1/providers/Microsoft.KeyVault/vaults/myvault1"
                       },
                       "vaultCertificates": [ {
                         "certificateUrl": "https://myvault1.vault.azure.net/secrets/{secretName}/{secretVersion}",
                         "certificateStore": "{certificateStoreName}"
                       } ]
                     } ]
                  },
                  "networkProfile": {
                    "networkInterfaces": [ {
                      "id":"/subscriptions/{subscription-id}/resourceGroups/myresourceGroup1/providers /Microsoft.Network/networkInterfaces/mynic1"
                    } ]
                  }
                }
              }'
          vm_mapper = Azure::ARM::Compute::Models::VirtualMachine.mapper
          compute_client.deserialize(vm_mapper, JSON.load(body), 'result.body')
        end
      end
    end
  end
end
