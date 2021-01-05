class API::V1::FunkisBookingsController < ApplicationController
  def index
    render :json => FunkisBooking.all, :except => [:updated_at, :created_at]
  end

  def show
    bookings = FunkisBooking.find(params[:id])
    render :json => bookings, :except => [:updated_at, :created_at]
  end

  def get_timeslots
    timeslots = FunkisBooking.find_all_by_funkis_id(params[:id])
    render :json => timeslots, except => [:updated_at, :created_at]
  end

  def get_funkis
    funkis = FunkisBooking.find_all_by_funkis_timeslot_id(params[:id])
    render :json => funkis, except => [:updated_at, :created_at]
  end

  def create
    booking = FunkisBooking.new(item_params)

    if booking.save
      render :status => 200, :json => {
          message: 'Successfully saved Booking.',
      }
    else
      render :status => 500, :json => {
          message: booking.errors
      }
    end
  end

  def update
  end

  def item_params
    params.require(:item).permit(
        :funkis_id,
        :timeslot_id
    )
  end
end
