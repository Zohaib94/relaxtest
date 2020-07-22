# frozen_string_literal: true

class LogReceiptsController < ApplicationController
  include Pundit

  before_action :authenticate_user!
  before_action :set_log_receipt, only: %i[show]
  before_action :authorize_log_receipt

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_free_user

  def index
    @log_receipts = current_user.log_receipts
  end

  def show; end

  private

  def set_log_receipt
    @log_receipt = LogReceipt.includes(:log_images).find(params[:id])
    redirect_to root_path, notice: 'You can not access this gallery' unless current_user.eql?(@log_receipt.user)
  end

  def authorize_log_receipt
    authorize LogReceipt
  end

  def unauthorized_free_user
    redirect_to root_path, notice: 'Gallery is only for premium users'
  end
end
