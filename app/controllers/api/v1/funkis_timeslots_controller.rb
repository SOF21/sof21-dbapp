class API::V1::FunkisTimeslotsController < ApplicationController

  include ViewPermissionConcern

  def index
    render :json => FunkisTimeslot.all, :except => [:updated_at, :created_at]
  end

  def show
    timeslot = FunkisTimeslot.find(params[:id])
    render :json => timeslot, :except => [:updated_at, :created_at]
  end

  def create
    require_admin_permission AdminPermission::LIST_FUNKIS_APPLICATIONS
    timeslot = FunkisTimeslot.new(item_params)

    if timeslot.save
      render :status => 201, :json => timeslot, :except => [:updated_at, :created_at]
    else
      render :status => 500, :json => {
          message: timeslot.errors
      }
    end
  end

  def update
    require_admin_permission AdminPermission::LIST_FUNKIS_APPLICATIONS
    timeslot = FunkisTimeslot.find(params[:id])

    if timeslot.update(item_params)
      render :status => 200, :json => timeslot, :except => [:updated_at, :created_at]
    else
      raise 'Unable to save page'
    end
  end

  def destroy
    require_admin_permission AdminPermission::LIST_FUNKIS_APPLICATIONS
    timeslot = FunkisTimeslot.find(params[:id])

    for booking in FunkisBooking.where(funkis_timeslot_id: params[:id])
      booking.delete
    end

    timeslot.destroy
    head :no_content
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
