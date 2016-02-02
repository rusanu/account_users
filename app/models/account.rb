
class Account < ActiveRecord::Base
  attr_accessor :terms_of_service
  has_many :account_user_roles

  validates :name, :presence => true, :uniqueness => true, :on => :create
  validates_acceptance_of :terms_of_service, :allow_nil => false, :on => :create
  
  scope :all_for_user, lambda {|user|
    joins(:account_user_roles).where('account_user_roles.user_id = ?',user.id)
  }

  def users
    User.all_for_account(self)
  end
end
