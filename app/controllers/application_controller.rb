class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?

	before_action :set_nbook
  def set_nbook
    @nbook = Book.new
  end



  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
