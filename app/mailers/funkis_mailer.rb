class FunkisMailer < ApplicationMailer
  Time.zone = "Stockholm"
  def funkis_confirmation(funkis)
    @funkis = funkis

    mail(to: @funkis.mail, subject: 'SOF21: Anmäld till funkis-pass')
  end

  def funkis_booked(funkis)
    @funkis = funkis
    @category = FunkisCategory.find(funkis.funkis_category_id)
    @timeslots = []
    bookings = FunkisBooking.where(funkis_id: funkis.id)
    bookings.each do |booking|
      @timeslots << FunkisTimeslot.find(booking.funkis_timeslot_id)
    end
    mail(to: @funkis.mail, subject: 'SOF21: Bokad till funkis-pass')
  end

  def funkis_unbooked(funkis)
    @funkis = funkis

    mail(to: @funkis.mail, subject: 'SOF21: Avbokad för funkis-pass')
  end
end
