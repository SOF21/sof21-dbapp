class API::V1::UsersController < ApplicationController
  include ViewPermissionConcern

  before_action :authenticate_user!

  def index
    require_admin_permission AdminPermission::LIST_USERS

    render :json => User.all
  end

  def show
    if params[:id].nil?
      render json: current_user,
             except: [
                 :created_at,
                 :updated_at,
                 :permissions
             ],
             include: [
                 :case_cortege,
                 :cortege,
                 :orchestra,
                 orchestra_signup: {
                     include: [
                         :orchestra
                     ]
                 }
             ],
             methods: [
                 :is_lintek_member,
                 :shopping_cart_count
             ]
    else
      require_admin_permission AdminPermission::LIST_USERS

      user = User.find(params[:id])
      render json: user
    end
  end

  def create
    raise 'User creation not supported'
  end

  def update
    user = User.find(params[:id])
    if current_user.has_admin_permission? AdminPermission::MODIFY_USERS
      if user.update(user_admin_params)
        redirect_to api_v1_user_url(user)
      else
        raise 'Unable to save user'
      end
    else
      require_ownership user

      if user.update(user_params)
        redirect_to '/api/v1/user'
      else
        raise 'Unable to save profile'
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.has_owner? current_user
      raise 'Cannot delete current user, use auth endpoint instead'
    end

    require_admin_permission AdminPermission::DELETE_USERS
    user.destroy

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(
        :display_name
    )
  end

  def user_admin_params
    require_admin_permission AdminPermission::MODIFY_USERS

    params.require(:user).permit(
        :display_name,
        :permissions
    )
  end
end
