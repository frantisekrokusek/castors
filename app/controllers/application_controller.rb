class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  layout :layout_by_resource

  def home
  end

  private

  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "application_unauthorized"
    end
  end
end
