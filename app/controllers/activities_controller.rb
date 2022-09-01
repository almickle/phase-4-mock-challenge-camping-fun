class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /activities
  def index
   activities = Activity.all
   render json: activities, status: :ok
  end

  # DELETE /activities/1
  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    activity.signups.destroy_all
    head :no_content
  end

  private

    # Only allow a list of trusted parameters through.
    def activity_params
      params.permit(:name, :difficulty)
    end

    def render_not_found_response
      render json: {error: "Activity not found"}, status: :not_found
    end

end
