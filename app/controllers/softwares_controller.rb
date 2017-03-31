class SoftwaresController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index,:new, :edit, :create, :update, :destroy]
  
  
  include ApplicationHelper
  # GET /softwares
  # GET /softwares.json
  def index
    #@softwares = current_user.software.all
    redirect_to root_path #dashboard
  end

  # GET /softwares/1
  # GET /softwares/1.json
  def show
  end

  # GET /softwares/new
  def new
    if can_add_software() == true
    @software = Software.new
    else
    #cant add any more software without upgrading
    flash[:warning] = "Shucks you reached your software limit..Time for an Upgrade"
    
    redirect_to root_path
    end
  end

  # GET /softwares/1/edit
  def edit
  end

  # POST /softwares
  # POST /softwares.json
  def create
    @software = current_user.software.new(software_params)
    set_software_token
    set_api_token
    respond_to do |format|
      if @software.save
        format.html { redirect_to root_path, notice: 'Software was successfully created.' }
        format.json { render :show, status: :created, location: @software }
      else
        format.html { render :new }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /softwares/1
  # PATCH/PUT /softwares/1.json
  def update
    respond_to do |format|
      if @software.update(software_params)
        format.html { redirect_to root_path, notice: 'Software was successfully updated.' }
        format.json { render :show, status: :ok, location: @software }
      else
        format.html { render :edit }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /softwares/1
  # DELETE /softwares/1.json
  def destroy
    @software.destroy
    respond_to do |format|
      format.html { redirect_to softwares_url, notice: 'Software was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def software_params
      params.require(:software).permit(:name, :description)
    end
    
    def set_software_token
    @software.software_key = generate_software_token
    end
    
    def set_api_token
    @software.api_key = generate_api_token
    end

    def generate_software_token
      loop do
        token = SecureRandom.hex(10)
        break token unless Software.where(software_key: token).exists?
      end
    end
    def generate_api_token
      loop do
        token = SecureRandom.hex(10)
        break token unless Software.where(api_key: token).exists?
      end
    end
end
