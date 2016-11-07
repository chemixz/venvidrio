class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected

	def authenticate_admin!
		redirect_to root_path unless  current_user.is_admin?
	end

	def authenticate_super!
		redirect_to root_path unless  current_user.is_super?
	end

end
