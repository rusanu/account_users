require 'active_support/concern'

module AccountUsers
  module ActiveModelConcern
    extend ActiveSupport::Concern
    
    def validate!
      raise (ActiveModel::ModelInvalidError.new(self)) if self.invalid?
    end
  end
end
