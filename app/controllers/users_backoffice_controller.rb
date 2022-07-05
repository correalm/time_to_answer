class UsersBackofficeController < ApplicationController
  layout 'users_backoffice'
  before_action :build_profile
  before_action :authenticate_user!
  
  private
  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank? 
  end
end
