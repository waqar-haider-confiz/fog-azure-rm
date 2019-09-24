module Fog
    module Compute
      class AzureRM
        # EncryptionSettings model for Compute Service
        class EncryptionSettingsCollection < Fog::Model
          attribute :enabled
          attribute :encryption_settings
  
          def self.parse(encryption_settings_collection)
            settings_collection = {}
            encryption_settings_arr = []

            settings_collection['enabled'] = encryption_settings_collection.enabled

            settings_collection.encryption_settings.each do |enc_settings|
                encryption_settings = Fog::Compute::AzureRM::EncryptionSettings.new
                encryption_settings_arr << encryption_settings.merge_attributes(Fog::Compute::AzureRM::EncryptionSettings.parse(enc_settings))
            end

            settings_collection['encryption_settings'] = encryption_settings_arr

            settings_collection
          end
        end
      end
    end
  end
  