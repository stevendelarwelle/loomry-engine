class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @software = current_user.software.all
  end
end
