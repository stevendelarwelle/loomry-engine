class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index,:new, :edit, :create, :update, :destroy]
  include ApplicationHelper
  
  # GET /licenses
  # GET /licenses.json
  def index
    if params[:software_id] then
    @licenses = current_user.licenses.where(:software_id => params[:software_id])  
    else
    @licenses = current_user.licenses.all
    end
  end

  # GET /licenses/1
  # GET /licenses/1.json
  def show
  end

  # GET /licenses/new
  def new
    if can_add_license() == true
    @license = License.new
    else
      flash[:warning] = "Dang..you reached your license limit!..Time to Upgrade"
    end
  end

  # GET /licenses/1/edit
  def edit
  end

  # POST /licenses
  # POST /licenses.json
  def create
    @license = current_user.licenses.new(license_params)
    set_license_key
    
    respond_to do |format|
      if @license.save
        format.html { redirect_to @license, notice: 'License was successfully created.' }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1
  # PATCH/PUT /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to @license, notice: 'License was successfully updated.' }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenses/1
  # DELETE /licenses/1.json
  def destroy
    @license.destroy
    respond_to do |format|
      format.html { redirect_to licenses_url, notice: 'License was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def license_params
      params.require(:license).permit(:software_id, :expiration_date, :is_active, :email)
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
    
end
