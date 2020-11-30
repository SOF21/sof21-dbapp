class API::V1::FunkisController < ApplicationController
  def index
    render :json => Funkis.all, :except => [:updated_at, :created_at]
  end

  def show
    funkis = Funkis.find(params[:id])
    render :json => funkis, :except => [:updated_at, :created_at]
  end

  def create
    funkis = Funkis.new(item_params)

    if funkis.save
      render :status => 200, :json => {
          message: 'Successfully saved Funkis.',
      }
    else
      render :status => 500, :json => {
          message: funkis.errors
      }
    end
  end

  private

  def item_params
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
        :liu_card,
        :funkis_category_id
    )
  end
end
