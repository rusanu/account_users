class LoginsController < AccountUsers::ControllerBase
  helper_method :login_presenters_path, :login_request_reset_path
  
  # TODO: fix respond_to for rails 5.rc2+ (moved to gem 'responders')
  #respond_to :html, :json, :xml

  def show
    @login_presenter = LoginPresenter.new
  end

  def create
    @login_presenter = LoginPresenter.new params_permit
    user = nil
    if @login_presenter.valid?
      user = User.user_lookup @login_presenter.user_name
    end
    if (user && user.is_password_match?(@login_presenter.password))
      account = AccountUsers.call_login_user session, user
      @login_presenter.account_name = account.name
      respond_to do |format|
        format.html {redirect_to AccountUsers.login_success_redirect_path}
        format.any(:json, :xml) {render 'login_success'}
      end
    else
      AccountUsers.call_logout_user session
      @login_presenter.errors.add :user_name, "Invalid user name or password mismatch" if @login_presenter.valid?
      respond_to do |format|
        format.html {render action: :show, status: :conflict}
        format.any(:json, :xml) {render 'login_failure', status: :unauthorized}
      end
    end
  end

  def destroy
      AccountUsers.call_logout_user session
      redirect_to AccountUsers.logout_redirect_path
  end

  def login_presenters_path
    AccountUsers::Engine.routes.url_helpers.login_path
  end

  def login_request_reset_path
    AccountUsers::Engine.routes.url_helpers.login_request_reset_path
  end

  private 

  def params_permit
    params.fetch(:login_presenter, {}).permit(
      :user_name,
      :password)
  end

end
