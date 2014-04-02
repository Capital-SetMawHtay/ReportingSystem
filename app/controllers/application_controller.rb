class ApplicationController < ActionController::Base
  protect_from_forgery
  append_before_filter :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url,status: 403,notice: "Access Denied on #{exception.action} with #{exception.subject.inspect}"
  end

  def after_sign_in_path_for(resource)
    case resource.role
      when 'admin' then admin_reports_path
      when 'leader'then user_reports_path(resource)
      when 'member'then user_reports_path(resource)
      else root_url
    end


  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
