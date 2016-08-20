class DateValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    !!(value.to_s =~ /\A\d{4}-\d{2}-\d{2}\z/)
  end

  def self.build(param_description, argument)
    if argument == Date
      self.new(param_description, argument)
    end
  end

  def description
    "Must be a #{@type}."
  end
end


class IntegerValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    !!(value =~ /\A\d+\z/)
  end

  def self.build(param_description, argument)
    if argument == Integer || argument == Fixnum
      self.new(param_description, argument)
    end
  end

  def description
    "Must be #{@type}"
  end
end
