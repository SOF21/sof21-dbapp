class API::V1::FunkisController < ApplicationController
  def index
    @result = []
    Funkis.all.each do |funkis|
      result = funkis.as_json
      if funkis.funkis_category_id
        category = FunkisCategory.find(funkis.funkis_category_id)
        result["category"] = category.title
        if FunkisBooking.where(funkis_id: funkis.id).exists?(conditions = :none)
          timeslots = FunkisBooking.where(funkis_id: funkis.id)
          result["timeslots"] = timeslots
        end
      end
      @result << result
    end
    render :json => @result
  end

  def show
    @funkis = Funkis.find(params[:id])
    result = @funkis.as_json
    if @funkis.funkis_category_id
      category = FunkisCategory.find(@funkis.funkis_category_id)
      result = result.merge({"funkis_category" => category.title})
    end
    if FunkisBooking.where(funkis_id: params[:id]).exists?(conditions = :none)
      timeslots = FunkisBooking.where(funkis_id: params[:id])
      result = result.merge({"timeslots" => timeslots})
    end
    render :json => result
  end

  def create
    if Funkis.where(liu_id: item_params_funkis[:liu_id]).exists?
      render :status => 500, :json => {
        message: "Funkis application already exists.",
      }
    else
      @funkis = Funkis.new(item_params_funkis)
      @funkis.build_funkis_application(item_params_application)
      @funkis.funkis_application_id = @funkis.funkis_application.id

      if @funkis.save
        FunkisMailer.funkis_confirmation(funkis).deliver_now
        render :status => 200, :json => {
          message: 'Successfully saved Funkis.',
        }
      else
        render :status => 500, :json => {
          message: @funkis.errors
        }
      end
    end
  end

  def update
    @funkis = Funkis.find(params[:id])

    if @funkis.update(item_params_funkis)
      attempt_to_finalize_funkis(@funkis)
      redirect_to api_v1_funkis_url(status: 303) and return
    else
      render :status => 500, :json => {
        message: @funkis.errors
      }
    end
  end

  def check_in_with_liu_card
      funkis = Funkis.find_by liu_card:(params[:id])
      if funkis.nil?
        render :status => 404, :json => {
          message: 'No funkis found with entered LiU card'
        }
      else
        funkis.checked_in = !funkis.checked_in
        funkis.save!
        render :status => 200, :json => funkis.as_json
      end
  end

  def check_in_with_liuid
    funkis = Funkis.find_by liu_id:(params[:id])
      if funkis.nil?
        render :status => 404, :json => {
          message: 'No funkis found with that LiU id'
        }
      else
        funkis.checked_in = !funkis.checked_in
        funkis.save!
        render :status => '200', :json => funkis.as_json
      end
  end

  private

  def attempt_to_finalize_funkis(funkis)
    if funkis.marked_done? and not funkis.booking_sent?
      FunkisMailer.funkis_booked(funkis).deliver_now
      funkis.booking_sent = true
      funkis.save
    elsif not funkis.marked_done? and funkis.booking_sent?
      FunkisMailer.funkis_unbooked(funkis).deliver_now
      funkis.booking_sent = false
      funkis.save
    end
  end

  def item_params_funkis
    params.require(:item).permit(
        :name,
        :liu_id,
        :mail,
        :phone_number,
        :post_address,
        :tshirt_size,
        :allergies,
        :allergies_other,
        :share_info,
        :gdpr,
        :funkis_application_id,
        :funkis_category_id,
        :association_name,
        :liu_card,
        :marked_done
    )
  end
  def item_params_application
    params.require(:item).permit(
        :first_day,
        :second_day,
        :third_day,
        :first_post_id,
        :second_post_id,
        :third_post_id,
        :user_id,
        :workfriend_id
    )
  end
end
