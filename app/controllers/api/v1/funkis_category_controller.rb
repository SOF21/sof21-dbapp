class API::V1::FunkisCategoryController < ApplicationController
  def index
    render :json => FunkisCategory.all, :except => [:updated_at, :created_at, :description]
  end

  def show
    category = FunkisCategory.find(params[:id])
    render :json => category, :except => [:updated_at, :created_at, :description]
  end

  def create
    restrict_access
    category = FunkisCategory.new(item_params)

    if category.save
      render :status => 200, :json => {
          message: 'Successfully saved FunkisCategory.',
      }
    else
      render :status => 500, :json => {
          message: funkis.errors
      }
    end
  end

  def update
    restrict_access

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
        :funkis_timeslots_id
    )
  end
end
