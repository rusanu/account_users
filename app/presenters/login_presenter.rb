class LoginPresenter
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  include ActiveModel::Translation

  attr_accessor :user_name, :password, :account_name

  validates :user_name, presence: true
  validates :password, presence: true
end
