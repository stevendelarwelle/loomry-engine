class Api::V1::LicenseSerializer < Api::V1::BaseSerializer
 attributes :is_active, :license
 
 def license
     if instance_options[:a] == true then
         object.license_key 
     
     end
 end
#   def created_at
#     object.created_at.in_time_zone.iso8601 if object.created_at
#   end

#   def updated_at
#     object.updated_at.in_time_zone.iso8601 if object.created_at
#   end
end