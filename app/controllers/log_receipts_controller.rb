class LogReceiptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_log_receipt, only: %i[show]

  def index
    @log_receipts = current_user.log_receipts
  end

  def show
  end

  private

  def set_log_receipt
    @log_receipt = LogReceipt.includes(:log_images).find(params[:id])
    redirect_to root_path, notice: 'You can not access this gallery' unless current_user.eql?(@log_receipt.user)
  end
end
