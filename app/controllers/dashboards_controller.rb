class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  def index
    @dashboards = Dashboard.sorted_for(current_user)
  end

  def show
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
    end
  end

  private
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    def dashboard_params
      dashboard_items_attributes = DashboardItem.attribute_names.map(&:to_sym).push(:_destroy)
      params.require(:dashboard).permit(:title, :order, :user_id, dashboard_items_attributes: dashboard_items_attributes).merge(user: current_user)
    end
end
