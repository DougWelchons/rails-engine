class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status, :error
end
