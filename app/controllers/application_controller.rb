class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_catalog
  helper_method :current_organization
  helper_method :current_inventory

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => I18n.t("errors.messages.access_denied")
  end

  def after_sign_in_path_for(resource)
    current_organization ? organization_path(current_organization) : root_path
  end

  def current_organization
    current_user && current_user.organization
  end

  def current_inventory
    current_organization && current_organization.inventories.order(created_at: :desc).find(&:compliant?)
  end

  def current_catalog
    current_organization && current_organization.current_catalog
  end

  def record_activity(category, description)
    if current_organization.present?
      @activity = ActivityLog.new(:category => category, :description => description, :organization_id => current_organization.id, :done_at => DateTime.now)
      @activity.save
    end
  end

  def set_locale
    I18n.locale = :es
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
