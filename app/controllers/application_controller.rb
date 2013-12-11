class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  def current_char
  	Character.find(current_user.selected_character_id)
  end

  def battle_session
    current_char.battles.first
  end

  private
  def not_authenticated
  	redirect_to login_path, alert: "Please login first"
	end

end
