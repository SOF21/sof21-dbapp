class API::V1::FunkisTimeslotsController < ApplicationController
  def index
    render :json => FunkisTimeslot.all, :except => [:updated_at, :created_at]
  end

  def show
    timeslot = FunkisTimeslot.find(params[:id])
    render :json => timeslot, :except => [:updated_at, :created_at]
  end

  def create
    timeslot = FunkisTimeslot.new(item_params)

    if timeslot.save
      render :status => 200, :json => {
          message: 'Successfully saved FunkisTimeslot.',
      }
    else
      render :status => 500, :json => {
          message: funkis.errors
      }
    end
  end

  def update


    timeslot = FunkisTimeslot.find(params[:id])

    if timeslot.update(item_params)
      redirect_to api_v1_funkis_timeslots_url(timeslot)
    else
      raise 'Unable to save page'
    end
  end

  def item_params
    params.require(:item).permit(
        :funkis_category_id,
        :funkis_id,
        :start_time,
        :end_time
    )

  end
end
