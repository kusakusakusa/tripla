class UserController < ApplicationController
  before_action :authenticate

  def authenticate
    @current_user = User.first
  end

  protected

  def current_user
    @current_user
  end
end
