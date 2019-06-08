class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

end
