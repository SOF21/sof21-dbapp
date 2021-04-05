class API::V1::FunkisBookingsController < ApplicationController
  def index
    render :json => FunkisBooking.all, :except => [:updated_at, :created_at]
  end

  def show
    bookings = FunkisBooking.find(params[:id])
    render :json => bookings, :except => [:updated_at, :created_at]
  end

  def get_timeslots
    timeslots = FunkisBooking.where(funkis_id: params[:id])
    render :json => timeslots
  end

  def get_funkis
    funkis = FunkisBooking.where(funkis_timeslot_id: params[:id])
    render :json => funkis
  end

  def create
    booking = FunkisBooking.new(item_params)

    if booking.save
      render :status => 201, :json => booking
    else
      render :status => 500, :json => {
          message: booking.errors
      }
    end
  end

  def update
  end

  def destroy_by_ids
    funkis_id = params[:fid]
    funkis_timeslot_id = params[:tid]
    booking = FunkisBooking.where(funkis_id: funkis_id, funkis_timeslot_id: funkis_timeslot_id).first
    if booking
      booking.destroy
    end
    head :no_content
  end

  private
  def item_params
    params.require(:item).permit(
        :funkis_id,
        :funkis_timeslot_id
    )
  end


end
