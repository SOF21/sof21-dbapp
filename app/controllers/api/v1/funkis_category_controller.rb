class API::V1::FunkisCategoryController < ApplicationController
  def index

    @result = []
    FunkisCategory.all.each do |category|
      amount_count = Funkis.where(funkis_category_id: category.id).count
      result = category.as_json.merge({"amount_count" => amount_count})
      @result << result
    end
    render :json => @result
  end

  def show
    category = FunkisCategory.find(params[:id]).as_json
    amount_count = Funkis.where(funkis_category_id: params[:id]).count
    category = category.merge({"amount_count" => amount_count})
    render :json => category, :except => [:updated_at, :created_at, :description]
  end

  def create
    category = FunkisCategory.new(item_params)

    if category.save
      render :status => 200, :json => {
          message: 'Successfully saved FunkisCategory.',
      }
    else
      render :status => 500, :json => {
          message: category.errors
      }
    end
  end

  def update
    category = FunkisCategory.find(params[:id])

    if category.update(item_params)
      redirect_to api_v1_funkis_category_url(category)
    else
      raise 'Unable to save page'
    end
  end

  def item_params
    params.require(:item).permit(
        :title,
        :description,
        :funkis_timeslots_id,
        :amount_needed
    )
  end
end
