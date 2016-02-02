class LoginPresenter
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  include ActiveModel::Translation

  attr_accessor :name, :password

  validates :name, presence: true
  validates :password, presence: true
end
