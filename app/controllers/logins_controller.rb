class LoginsController < AccountUsers::ControllerBase
  helper_method :login_presenters_path, :login_request_reset_path

  def show
    @login_presenter = LoginPresenter.new
  end

  def create
    @login_presenter = LoginPresenter.new params_permit
    user = nil
    if @login_presenter.valid?
      user = User.user_lookup @login_presenter.name
    end
    if (user && user.is_password_match?(@login_presenter.password))
      AccountUsers.call_login_user session, user
      redirect_to AccountUsers.login_success_redirect_path
    else
      @login_presenter.errors.add :name, "Invalid user name or password mismatch" if @login_presenter.valid?
      AccountUsers.call_logout_user session
      render action: :show, status: :conflict
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
      :name,
      :password)
  end

end
