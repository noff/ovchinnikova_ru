class ApplicationController < ActionController::Base

  http_basic_authenticate_with name: Rails.application.credentials.admin_user, password: Rails.application.credentials.admin_pass, if: :admin_controller?

  def admin_controller?
    self.class < ActiveAdmin::BaseController
  end

end
