module ActiveModel
  class ModelInvalidError < StandardError
    attr_reader :model

    def initialize(model)
      @model = model
      super "#{@model.class}.errors.messages.record_invalid"
    end
  end
end
