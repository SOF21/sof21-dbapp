class API::V1::FunkisController < ApplicationController
  def index
    render :json => Funkis.all, :except => [:updated_at, :created_at]
  end

  def show
    @funkis = Funkis.find(params[:id])
    render :json => @funkis, :except => [:updated_at, :created_at]
  end

  def create
    @funkis = Funkis.new(item_params_funkis)
    @funkis.build_funkis_application(item_params_application)
    @funkis.funkis_application_id = @funkis.funkis_application.id

    if @funkis.save
      render :status => 200, :json => {
        message: 'Successfully saved Funkis.',
      }
    else
      render :status => 500, :json => {
        message: @funkis.errors
      }
    end
  end

  def update

    funkis = Funkis.find(params[:id])

    if funkis.update(item_params_funkis)
      redirect_to api_v1_funkis_url(funkis)
    else
      raise 'Unable to save page'
    end
  end

  private

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
        :association_name,
        :liu_card
    )
  end
  def item_params_application
    params.require(:item).permit(
        :first_day,
        :second_day,
        :third_day,
        :first_post_id,
        :second_post_id,
        :third_post_id
    )
  end
end
