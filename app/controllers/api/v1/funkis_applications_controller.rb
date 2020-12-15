class API::V1::FunkisApplicationsController < ApplicationController
  def index
    render :json => FunkisApplication.all, :except => [:updated_at, :created_at]
  end

  def show
    @fapplication = FunkisApplication.find(params[:id])
    categories = {}
    if @fapplication.first_post_id
      categories["first_post"] = @fapplication.first_post.title
    end
    if @fapplication.second_post_id
      categories["second_post"] = @fapplication.second_post.title
    end
    if @fapplication.third_post_id
      categories["third_post"] = @fapplication.third_post.title
    end
    render :json => @fapplication.attributes.merge(categories), :except => [:updated_at, :created_at]
  end

  def create
    restrict_access
  end

  def update
    @fapplication = FunkisApplication.find(params[:id])

    if @fapplication.update(item_params)
      redirect_to api_v1_funkis_url(@fapplication)
    else
      raise 'Unable to save page'
    end
  end

  def item_params
    params.require(:item).permit(
        :funkis_id,
        :first_day,
        :second_day,
        :third_day,
        :first_post_id,
        :second_post_id,
        :third_post_id
    )
  end
end
