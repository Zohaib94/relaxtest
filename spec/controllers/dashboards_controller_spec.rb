# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      sign_in create(:user)
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before(:each) do
        sign_in create(:user)
      end

      let(:dashboard_params) do
        {
          dashboard: attributes_for(:dashboard),
          user: User.first
        }
      end

      it 'creates a new dashboard' do
        expect do
          post :create, params: dashboard_params
        end.to change(Dashboard, :count).by(1)
      end

      it 'redirects to the created dashboard' do
        post :create, params: dashboard_params
        expect(response).to redirect_to(Dashboard.last)
      end
    end

    context 'with invalid params' do
      before(:each) do
        sign_in create(:user)
      end

      let(:dashboard_params) do
        {
          dashboard: attributes_for(:dashboard, :invalid),
          user: User.first
        }
      end

      it 're-renders the new form on create' do
        post :create, params: dashboard_params
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      before(:each) do
        sign_in create(:user)
      end

      let(:dashboard) { create(:dashboard, user: User.last) }
      let(:dashboard_items_params) do
        {
          id: dashboard.id,
          dashboard: attributes_for(:dashboard,
                                    dashboard_items_attributes: [attributes_for(:dashboard_item, dashboard: dashboard)],
                                    user: User.first)
        }
      end

      it 'updates dashboard and adds a new dashboard item' do
        expect do
          patch :update, params: dashboard_items_params
        end.to change(DashboardItem, :count).by(1)
      end

      it 'redirects to the updated dashboard' do
        patch :update, params: dashboard_items_params
        expect(response).to redirect_to(Dashboard.last)
      end
    end
  end

  describe 'GET #preview' do
    context 'with valid params' do
      before(:each) do
        sign_in create(:user)
      end

      it 'displays review page' do
        get :preview
        expect(response).to render_template('preview')
      end

      it 'shows dashboards in ascending order of the order given' do
        create(:dashboard, user: User.last)
        create(:dashboard, user: User.last)

        get :preview
        orders = assigns(:dashboards).pluck(:order)
        expect(orders).to eq(orders.sort)
      end
    end
  end
end
