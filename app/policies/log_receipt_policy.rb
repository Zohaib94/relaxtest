# frozen_string_literal: true

class LogReceiptPolicy
  attr_reader :user, :log_receipt

  def initialize(user, log_receipt)
    @user = user
    @log_receipt = log_receipt
  end

  def index?
    user.free? || user.premium?
  end

  def show?
    user.premium?
  end
end
