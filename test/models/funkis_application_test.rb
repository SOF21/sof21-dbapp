require 'test_helper'

class FunkisApplicationTest < ActiveSupport::TestCase
  test 'application process' do
    application = FunkisApplication.new

    assert application.ready_for_step? 1
    assert_not application.ready_for_step? 2

    application.ssn = '900101-0101'
    application.phone = '013176800'
    application.tshirt_size = 'Female XS'
    application.allergies = 'Jordnötter'
    application.drivers_license = true
    application.presale_choice = 1

    assert application.ready_for_step? 2
    assert_not application.ready_for_step? 3

    shift = FunkisShiftApplication.new
    shift.funkis_shift = funkis_shifts(:one)

    application.funkis_shift_applications.push shift

    assert application.ready_for_step? 3
    assert_not application.ready_for_step? 4

    application.terms_agreed_at = DateTime.now

    assert application.ready_for_step? 4
  end
end
