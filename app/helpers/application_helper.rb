module ApplicationHelper
    include Koudoku::ApplicationHelper
    
    def get_plan_id()
        @sub= Subscription.where(:user_id => current_user.id).first
        if @sub.nil? then return nil
        else
        return @sub.plan_id
        end
    end
    
    
    def can_add_software()
        plan_id = get_plan_id()
        
        if plan_id == 1 #plan 1 allows for 1 software and 200 licenses
            if current_user.software.count < 1 
                return true
            else
                return false
            end
        elsif plan_id == 2 #plan 2 allows for 3 software and 3000 licenses
            if current_user.software.count < 10
                return true
            else
                return false
            end
            
        elsif plan_id == 3 #plan 3 allows for unlimited software and licenses
            return true
        else plan_id.nil?  #free plan allows for 1 sofware and 10 licenses  
            if current_user.software.count < 1
                return true
            else
                return false
            end
        end
    end
    
    def can_add_license()
        plan_id = get_plan_id()
        
        if plan_id == 1 #plan 1 allows for 1 software and 200 licenses
            if current_user.licenses.count < 200 
                return true
            else
                return false
            end
        elsif plan_id == 2 #plan 2 allows for 3 software and 3000 licenses
            if current_user.licenses.count < 5000
                return true
            else
                return false
            end
            
        elsif plan_id == 3 #plan 3 allows for unlimited software and licenses
            return true
        else plan_id.nil?  #free plan allows for 1 sofware and 10 licenses  
            if current_user.licenses.count < 5
                return true
            else
                return false
            end
        end
    end
    
    def get_metrics()
     if Subscription.exists?(:user_id => current_user.id)
         return true
     else
         return false
     end   
    end
    
    def get_software_stats()
       softmax = 0
       licmax = 0
       curr_lic = current_user.licenses.count
       curr_software = current_user.software.count
       
       plan_id = get_plan_id()
       
       if plan_id == 1 then 
           softmax = 1 
           licmax= 500 
           end
       if plan_id == 2 then 
           softmax = 10 
           licmax= 5000
           end
       if plan_id == 3 then 
           softmax = 'unlimited' 
           licmax = 'unlimited' 
           end
       if plan_id.nil? then 
           softmax = 1 
           licmax = 10 
           end 
 
      return curr_software.to_s + '/' + softmax.to_s + ' software(s) and ' + curr_lic.to_s + '/' + licmax.to_s  
    end
    def get_license_count_by_software(software_id)
       count = current_user.licenses.where(:software_id => software_id).count 
       return count.to_s
    end
    def get_software_name(id)
     @s =  Software.where(:id => id).first
     puts @s.name
     return @s.name
    end
end
