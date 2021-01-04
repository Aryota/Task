class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  unless Rails.env.development?
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :render_404
    rescue_from ActionController::RoutingError,   with: :render_404
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.xhr?
      render json: { error: "404 error" }, status: 404
    else
      format = params[:format] == :json ? :json : :html
      render file: Rails.root.join("public/404.html"), status: 404, layout: false, content_type: "text/html"
    end
  end

  def render_500(e = nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e

    if request.xhr?
      render json: { error: "500 error" }, status: 500
    else
      format = params[:format] == :json ? :json : :html
      render file: Rails.root.join("public/500.html"), status: 500, layout: false, content_type: "text/html"
    end
  end

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      redirect_to login_url if current_user.blank?
    end
end
