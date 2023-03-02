class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, ActiveRecord::RecordInvalid, with: :generic

  private

  def generic(exception)
    render json: { error: exception.message }
  end
end
