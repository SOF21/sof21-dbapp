class API::V1::FunkisCategoryController < ApplicationController
  include ViewPermissionConcern

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
      render :status => 200, :json => category
    else
      render :status => 500, :json => {
          message: category.errors
      }
    end
  end

  def destroy
    require_admin_permission AdminPermission::LIST_FUNKIS_APPLICATIONS
    funkis_category = FunkisCategory.find(params[:id])

    funkis_timeslots = FunkisTimeslot.where(funkis_category_id: params[:id])
    for timeslot in funkis_timeslots
      timeslot.delete
    end

    # Set any application using this Category to nil
    for fa in FunkisApplication.where(first_post_id: params[:id]).or(FunkisApplication.where(second_post_id: params[:id]).or(FunkisApplication.where(third_post_id: params[:id])))
      if fa.first_post_id == funkis_category.id
        fa.first_post_id = nil
      end
      if fa.second_post_id == funkis_category.id
        fa.second_post_id = nil
      end
      if fa.third_post_id == funkis_category.id
        fa.third_post_id = nil
      end
    end

    funkis_category.delete

    head :no_content
  end

  def update
    category = FunkisCategory.find(params[:id])

    if category.update(item_params)
      render :status => 200
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
