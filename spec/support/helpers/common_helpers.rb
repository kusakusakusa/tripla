module CommonHelpers
  def response_body
    JSON.parse(response.body, object_class: OpenStruct)
  end
end
