class Api::V1::LicensesController < Api::V1::BaseController
  
  
  def show
    key = params[:license_key]
    license = License.find_by(:license_key => key)
    if !license.nil?
        render json: license
    else
        return api_error(status: 404, errors: 'Not found')
    end
  end
  
  def confirm
    key = params[:license_key]
    soft_key = params[:software_key]
    if !Software.find_by(:software_key => soft_key).nil?
    
        license = License.find_by(:license_key => key)
        if !license.nil?
            render json: license
        else
            return api_error(status: 404, errors: 'Not found')
        end
        
    else
        return api_error(status: 404, errors: 'Not found')
    end
  end
  
 
  def create
    software = Software.find_by(:software_key => create_params[:software_key])
      
      if !software.nil? && !create_params[:email].nil? then
        user = User.find(software.user_id)
          if can_add_license(user) == true then
            @license = License.new()
            @license.software_id = software.id
            @license.email = create_params[:email]
            @license.is_active = true
            @license.expiration_date = Date.today + 1.year
            set_license_key
            
            return api_error(status: 422, errors: @license.errors) unless @license.valid?
        
            if @license.save!
              render json: @license, a: true, status: 201, location: api_v1_licenses_confirm_url(@license)
            else
              return api_error(status: 404, errors: 'License Not Created')
            end
          
          else
            return api_error(status: 404, errors: 'Reached Max License Count')
          end
      else
        return api_error(status: 404, errors: 'Software Not found, or missing params')
      end
  end
  
  
  
  private
  def create_params
    params.permit(
      :email, :software_key).delete_if{ |k,v| v.nil?}
  end
  
  def set_license_key
    @license.license_key = generate_token
  end

    def generate_token
      loop do
        token = SecureRandom.hex(20)
        break token unless License.where(license_key: token).exists?
      end
    end
  
  def get_plan_id(user_id)
        @sub= Subscription.find_by(:user_id => user_id)
        if @sub.nil? then return nil
        else
        return @sub.plan_id
        end
  end  
  
  def can_add_license(user)
        plan_id = get_plan_id(user.id)
        
        if plan_id == 1 #plan 1 allows for 1 software and 200 licenses
            if user.licenses.count < 200 
                return true
            else
                return false
            end
        elsif plan_id == 2 #plan 2 allows for 3 software and 3000 licenses
            if user.licenses.count < 5000
                return true
            else
                return false
            end
            
        elsif plan_id == 3 #plan 3 allows for unlimited software and licenses
            return true
        else plan_id.nil?  #free plan allows for 1 sofware and 10 licenses  
            if user.licenses.count < 5
                return true
            else
                return false
            end
        end
  end    
    
end
