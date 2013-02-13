class Private::Api::UsersController < ActionController::Base
  before_filter :authenticate_api!
  before_filter :ensure_params, only: [:create, :update]
  before_filter :ensure_user, only: [:update, :destroy]

  respond_to :json

  def create
    @user = User.new params[:user]
    if @user.save
      render :json => {user: @user}
    else
      render :json => {:success=>false, :message=>"Failed to create the user", :errors=>@user.errors}, :status=>500
    end
  end

  def update
    if @user.update_attributes params[:user]
      render :json => {user: @user}
    else
      render :json => {:success=>false, :message=>"Failed to update the user", :errors=>@user.errors}, :status=>500
    end
  end

  def show
    @user = User.where(email: params[:id]).first
    if @user
      respond_with(@user)
    else
      render :json => {:success=>false, :message=>"That user was not found"}, :status=>404
    end
  end

  def destroy
    if @user.destroy
      render :json => {:success=>true}
    else
      render :json => {:success=>false, :message=>"Failed to delete the user", :errors=>@user.errors}, :status=>500
    end
  end

protected

  def authenticate_api!
    unless params[:api_token] && params[:api_token] === APP_CONFIG['api_auth_token']
      render :json => {:success=>false, :message=>"Failed to authenticate with the api"}, :status=>401
    end
  end

  def ensure_params
    unless params[:user]
      render :json => {:success=>false, :message=>"Missing user param"}, :status=>422
    end
  end

  def ensure_user
    @user = User.find params[:id]
    render :json => {:success=>false, :message=>"That user was not found"}, :status=>404 unless @user
  end
end
