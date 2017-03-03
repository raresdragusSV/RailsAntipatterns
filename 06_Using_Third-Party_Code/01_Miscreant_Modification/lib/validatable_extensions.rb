module Validatable
  class ValidatesNumericalityOf < ValidationBase
    def valid?(instance)
      value = value_for(instance)
      return true if allow_nil && value.nil?
      return true if allow_blank && value.blank?
      value = value.to_s
      regex = only_integer ? /\A[+-]?\d+\Z/ : /\A[+-]?\d*\.{0,1}\d+$/
      not (value =~ regex).nil?
    end
  end
end
