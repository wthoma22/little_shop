class Admin::DashboardsController < Admin::BaseController

  def index

  end

  def show

  end

  def edit
    @user = User.find(params[:id])
  end
end
