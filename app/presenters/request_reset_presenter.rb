class RequestResetPresenter
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email

  validates :email, presence: true

  def persisted?
    false
  end

end
