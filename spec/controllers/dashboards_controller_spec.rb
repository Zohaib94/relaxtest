# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  describe 'GET #index' do
    it 'renders index template' do
      sign_in create(:user)
      get :index
      expect(response).to render_template('index')
    end
  end
end
