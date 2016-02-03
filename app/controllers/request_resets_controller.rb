class RequestResetsController < AccountUsers::ControllerBase
  helper_method :request_reset_presenters_path

  def show
    @request_reset_presenter = RequestResetPresenter.new
  end

  def create
    @request_reset_presenter = RequestResetPresenter.new params_permit
    if @request_reset_presenter.invalid?
      render action: :show, status: :conflict
    else
      user = User.email_lookup @request_reset_presenter.email
      unless user.nil?
        # rescue all exception to prevent leakage of account existance
        begin
          UserMailer.reset_password(user).deliver_now
        rescue Exception => e
          Rails.logger.error "Exception in RequestResetsController::create: #{e.class.name}:  #{e.message}"
        end
      end
    end
  end

  def request_reset_presenters_path
    AccountUsers::Engine.routes.url_helpers.login_request_reset_path
  end

  private

  def params_permit
    params.require(:request_reset_presenter).permit(:email)
  end

end
