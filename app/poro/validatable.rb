module Validatable
  def valid_param?(param, min_value = 1)
    return true if (param && param !="") && param.to_i >= min_value
    false
  end

  def valid_optional_param?(param, min_value = 1)
    return true if (param && param !="") && param.to_i >= min_value
    return true unless param
    false
  end

  def valid_search?(name, min, max)
    return false if name && (min || max)
    return false if max && min.to_f > max.to_f
    return true if all_optional_params_are_valid?([name, min, max]) &&
                   has_valid_required_params?([name, min, max])
  end

  def all_optional_params_are_valid?(params)
    params.all? do |param|
      valid_optional_param?(param, 0)
    end
  end

  def has_valid_required_params?(params)
    params.any? do |param|
      valid_param?(param, 0)
    end
  end
end
