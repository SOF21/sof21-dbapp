class API::V1::LineupsController < ApplicationController
  include ViewPermissionConcern

  def index
    render :json => Lineup.all, :except => [:updated_at, :created_at]
  end

  def create
    require_admin_permission AdminPermission::LIST_CORTEGE_APPLICATIONS
    lineup = Lineup.new(item_params)
    lineup.save!
    render :status => 201, :json => lineup
  end

  def show
    require_admin_permission AdminPermission::LIST_CORTEGE_APPLICATIONS
    lineup = Lineup.find(params[:id])
    render :json => lineup, :except => [:updated_at, :created_at]
  end

  def update
    require_admin_permission AdminPermission::LIST_CORTEGE_APPLICATIONS
    lineup = Lineup.find(params[:id])
    if lineup.update(item_params)
      render :status => 200, :json => lineup
    else
      raise 'Unable to update lineup'
    end
  end

  def destroy
    require_admin_permission AdminPermission::LIST_CORTEGE_APPLICATIONS
    lineup = Lineup.find(params[:id])
    lineup.destroy
    head :no_content
  end

  def get_corteges
    render :json => Lineup.where(cortege: true), :except => [:updated_at, :created_at]
  end

  def get_artists
    render :json => Lineup.where(orchestra: true), :except => [:updated_at, :created_at]
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :image,
      :order,
      :orchestra,
      :ballet,
      :cortege
    )
  end

end
