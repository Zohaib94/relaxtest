# frozen_string_literal: true

ActiveAdmin.register User do
  form do |f|
    f.inputs 'User' do
      f.input :email, disabled: true
      f.input :role, as: :select, collection: User::ROLES
    end

    f.actions
  end

  index do
    column :id
    column :email
    column :role

    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
    end
  end

  permit_params :role
end
