class ApplicationController < ActionController::Base
  protect_from_forgery


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url,status: 403,notice: "Access Denied"
  end

  def after_sign_in_path_for(resource)
    case resource.role
      when 'admin' then reports_path
      when 'leader'then member_reports_path
      when 'member'then member_reports_path
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
