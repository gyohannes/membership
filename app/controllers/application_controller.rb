class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  respond_to :html, :js, :json
  layout :set_layout
  before_action :set_institution, :set_association

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  private

  def set_layout
    unless current_user
      return 'landing_page'
    else
      return 'application'
    end
  end

  def set_association
    @association = AssociationDetail.first rescue nil
    @current_board_term = BoardMembersTerm.active
  end
  def set_institution
    @institution = current_user.institution rescue nil
  end

end
