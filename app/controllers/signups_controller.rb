class SignupsController < AccountUsers::ControllerBase
  include ActiveSupport::Callbacks
  helper_method :signup_presenters_path, :terms_of_service_path

  define_callbacks :create_account

  def show
    @signup_presenter = SignupPresenter.new
  end

  def create
    @signup_presenter = SignupPresenter.new params_permit
    run_callbacks :create_account do
      if (!@signup_presenter.save)
        render action: :show, status: :conflict
      else
        AccountUsers.account_provision.call @signup_presenter.account, @signup_presenter.user
        AccountUsers.call_login_user session, @signup_presenter.user
        redirect_to AccountUsers.login_success_redirect_path, flash: {new_account: true}
      end
    end
  end

  def terms_of_service_path
    AccountUsers.terms_of_service_path
  end

  def signup_presenters_path
    AccountUsers::Engine.routes.url_helpers.signup_path
  end

  private 

  def params_permit
   params.fetch(:signup_presenter, {}).permit(
      :account_name,
      :user_name,
      :user_email,
      :user_password,
      :user_password_confirmation,
      :account_terms_of_service)
  end


end
