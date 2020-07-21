ActiveAdmin.register LogReceipt do
  form html: { enctype: "multipart/form-data" } do |f|
    f.inputs "LogReceipt", multipart: true do
      f.input :invoiced_at, as: :datepicker, start_year: 1900
      f.input :amount
      f.input :quantity
      f.input :average_weight
      f.input :average_diameter
      f.input :average_length
      f.input :user, as: :select, collection: User.all.pluck(:email, :id)

      f.has_many :log_images, heading: 'Log Images',
                              allow_destroy: true,
                              new_record: true do |attachment|
        attachment_thumbnail = attachment.object.thumbnail ? image_tag(attachment.object.thumbnail) : nil
        attachment.input :attached_image, hint: attachment_thumbnail, as: :file
      end
    end

    f.actions
  end

  index do
    column :id
    column :invoiced_at
    column :amount
    column :quantity
    column :average_weight
    column :average_diameter
    column :average_length

    column 'User' do |log_receipt|
      log_receipt.user_email
    end

    column 'Gallery Images' do |log_receipt|
      log_receipt.log_images.each do |log_image|
        span do
          image_tag(log_image.thumbnail)
        end
      end
    end

    actions
  end

  show do
    attributes_table do
      row :id
      row :invoiced_at
      row :amount
      row :quantity
      row :average_weight
      row :average_diameter
      row :average_length
  
      row 'User' do |log_receipt|
        log_receipt.user_email
      end

      row 'Gallery Images' do |log_receipt|
        log_receipt.log_images.each do |log_image|
          div do
            image_tag(log_image.thumbnail)
          end
        end
      end
    end
  end

  permit_params :user_id, :invoiced_at, :average_diameter, :quantity, :average_weight, :average_length, :amount, log_images_attributes: [:id, :attached_image, :_destroy]
end
