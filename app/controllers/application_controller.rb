class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_search, except: [:top, :about]

  private
  def set_search
    @search = Search.new(search_params)
  end




  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
  def search_params
    params.fetch(:q, {}).permit(:content, :model, :method)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
