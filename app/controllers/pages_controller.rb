class PagesController < ApplicationController
  def home
    if current_user
      redirect_to dashboard_index_path
    end
  end

  def about
  end
end
