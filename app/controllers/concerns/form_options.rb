module FormOptions
  class FormOption
    attr_accessor :text, :value

    def initialize(text, value)
      self.text = text
      self.value = value
    end

  end
end