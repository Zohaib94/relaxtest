# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogReceiptsController, type: :controller do
  INVALID_LOG_RECEIPT_ID = 0

  describe 'GET #index' do
    context 'when user access his own index' do
      before(:each) { sign_in create(:user) }

      it 'renders index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when admin accesses the user site' do
      before(:each) { sign_in create(:admin_user) }

      it 'renders error and redirects to sign in page if admin tries to access' do
        get :index

        expect(response.request.flash[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user tries to access index without logging in' do
      it 'renders error and redirects to sign in page if admin tries to access' do
        get :index

        expect(response.request.flash[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when premium user access his own gallery with valid params' do
      before(:each) { sign_in create(:user, :with_premium) }

      it 'shows his gallery items' do
        log_receipt = create(:log_receipt, user: User.last)

        get :show, params: { id: log_receipt.to_param }
        expect(response).to render_template('show')
      end
    end

    context 'when premium user access his own gallery with invalid params' do
      before(:each) { sign_in create(:user, :with_premium) }

      it 'redirects him to root url' do
        create(:log_receipt, user: User.last)

        get :show, params: { id: INVALID_LOG_RECEIPT_ID }

        expect(response.request.flash[:notice]).to_not be_nil
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when user accesses other users gallery' do
      before(:each) { sign_in create(:user, :with_premium) }

      it 'redirects him to root url' do
        create(:user, :with_premium)
        log_receipt = create(:log_receipt, user: User.last)

        get :show, params: { id: log_receipt.id }

        expect(response.request.flash[:notice]).to_not be_nil
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when free user accesses gallery' do
      before(:each) { sign_in create(:user) }

      it 'redirects him to root url' do
        log_receipt = create(:log_receipt, user: User.last)

        get :show, params: { id: log_receipt.id }

        expect(response.request.flash[:notice]).to_not be_nil
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when admin tries to access gallery' do
      before(:each) { sign_in create(:admin_user) }

      it 'renders error and redirects to sign in page if admin tries to access' do
        create(:user)
        log_receipt = create(:log_receipt, user: User.last)

        get :show, params: { id: log_receipt.to_param }

        expect(response.request.flash[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user tries to access gallery without logging in' do
      it 'renders error and redirects to sign in page if admin tries to access' do
        create(:user)
        log_receipt = create(:log_receipt, user: User.last)

        get :show, params: { id: log_receipt.to_param }

        expect(response.request.flash[:alert]).to_not be_nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
