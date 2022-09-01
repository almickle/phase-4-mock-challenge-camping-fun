class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # POST /signups
  def create
    signup = Signup.create!(signup_params)
    render json: signup, status: :created
  end

  private

    # Only allow a list of trusted parameters through.
    def signup_params
      params.permit(:camper_id, :activity_id, :time)
    end

    def render_unprocessable_entity_response(invalid)
      render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
