class Module
  def attribute(params, &block)
    if params.is_a? Hash
      key, value = params.to_a.first
    else
      key = params
    end

    variable_name = "@#{key}"

    define_method(key) do
      if instance_variable_defined? variable_name
        instance_variable_get(variable_name)
      else
        block ? instance_eval(&block) : value
      end
    end

    self.__send__(:define_method, "#{key}=") do |new_value|
      instance_variable_set(variable_name, new_value)
    end
    self.__send__(:define_method, "#{key}?") { !self.__send__(key).nil?  }
  end
end