class Admin::DashboardController < Admin::BaseController

  def index

  end

  def show
    @orders = Order.all
  end

  def edit
    @user = User.find(params[:id])
  end
end
