class API::V1::FunkisController < ApplicationController
  def index
    @result = []
    Funkis.all.each do |funkis|
      if funkis.funkis_category_id
        category = FunkisCategory.find(funkis.funkis_category_id)
        @result << funkis.attributes.merge({"funkis_category" => category.title})
      else
        @result << funkis
      end

    end
    render :json => @result
  end

  def show
    @funkis = Funkis.find(params[:id])
    if @funkis.funkis_category_id
      @category = FunkisCategory.find(@funkis.funkis_category_id)
      render :json => @funkis.attributes.merge({"funkis_category" => @category.title})
    else
      render :json => @funkis
    end
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
    @funkis = Funkis.find(params[:id])

    if @funkis.update(item_params_funkis)
      redirect_to api_v1_funkis_url(@funkis)
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
        :funkis_category_id,
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
