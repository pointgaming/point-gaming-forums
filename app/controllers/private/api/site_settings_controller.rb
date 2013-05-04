class Private::Api::SiteSettingsController < Private::Api::BaseController
  before_filter :ensure_params, only: [:create, :update]
  before_filter :ensure_site_setting, only: [:update, :destroy]

  def create
    @site_setting = SiteSetting.new params[:site_setting]
    if @site_setting.save
      render :json => {site_setting: @site_setting}
    else
      render :json => {:success=>false, :message=>"Failed to create the site_setting", :errors=>@site_setting.errors}, :status=>500
    end
  end

  def update
    if @site_setting.update_attributes params[:site_setting]
      render :json => {site_setting: @site_setting}
    else
      render :json => {:success=>false, :message=>"Failed to update the site_setting", :errors=>@site_setting.errors}, :status=>500
    end
  end

  def show
    @site_setting = SiteSetting.where(key: params[:id]).first
    if @site_setting
      respond_with(@site_setting)
    else
      render :json => {:success=>false, :message=>"That site_setting was not found"}, :status=>404
    end
  end

  def destroy
    if @site_setting.destroy
      render :json => {:success=>true}
    else
      render :json => {:success=>false, :message=>"Failed to delete the site_setting", :errors=>@site_setting.errors}, :status=>500
    end
  end

protected

  def ensure_params
    unless params[:site_setting]
      render :json => {:success=>false, :message=>"Missing site_setting param"}, :status=>422
    end
  end

  def ensure_site_setting
    @site_setting = SiteSetting.find params[:id]
    render :json => {:success=>false, :message=>"That site_setting was not found"}, :status=>404 unless @site_setting
  end

end
