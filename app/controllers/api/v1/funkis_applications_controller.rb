class API::V1::FunkisApplicationsController < ApplicationController
  def index
    render :json => FunkisApplication.all, :except => [:updated_at, :created_at]
  end

  def show
    fapplication = FunkisApplication.find(params[:id])
    render :json => fapplication, :except => [:updated_at, :created_at]
  end

  def create
    restrict_access
  end

  def item_params
    params.require(:item).permit(
        :funkis_id,
        :first_day,
        :second_day,
        :third_day,
        :first_post_id,
        :second_post_id,
        :third_post_id
    )
  end
end
