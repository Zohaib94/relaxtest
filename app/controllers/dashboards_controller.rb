# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard, only: %i[edit update destroy]

  def index
    @dashboards = Dashboard.sorted_for(current_user)
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit; end

  def create
    @dashboard = Dashboard.new(dashboard_params)

    if @dashboard.save
      redirect_to dashboards_url, notice: 'Dashboard was successfully created.'
    else
      render :new
    end
  end

  def update
    if @dashboard.update(dashboard_params)
      redirect_to dashboards_url, notice: 'Dashboard was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @dashboard.destroy
    redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.'
  end

  def preview
    @dashboards = Dashboard.sorted_with_content_for(current_user)
  end

  private

  def set_dashboard
    @dashboard = Dashboard.find(params[:id])
    redirect_to root_path, notice: 'You can not access this dashboard' unless current_user.eql?(@dashboard.user)
  end

  def dashboard_params
    dashboard_items_attributes = DashboardItem.attribute_names.map(&:to_sym).push(:_destroy)
    params
      .require(:dashboard)
      .permit(:title, :order, :user_id, dashboard_items_attributes: dashboard_items_attributes)
      .merge(user: current_user)
  end
end
