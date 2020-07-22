module LogReceiptsHelper
  def average_weight_for(log_receipt)
    return 'N/A' if log_receipt.average_weight.blank?
    log_receipt.average_weight
  end

  def average_length_for(log_receipt)
    return 'N/A' if log_receipt.average_length.blank?
    log_receipt.average_length
  end

  def average_diameter_for(log_receipt)
    return 'N/A' if log_receipt.average_diameter.blank?
    log_receipt.average_diameter
  end
end
