# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'user creates a new project' do
  scenario 'should require a user login before creating a project ' do
    old_count = LogReceipt.count

    create(:user)
    admin_user = create(:admin_user)
    visit new_admin_user_session_path

    fill_in 'admin_user_email', with: admin_user.email
    fill_in 'admin_user_password', with: admin_user.password
    click_button 'Login'

    expect(page).to have_link(nil, href: '/admin/log_receipts')

    log_receipts_button = page.find('li#log_receipts > a')
    log_receipts_button.click

    expect(page).to have_link(nil, href: '/admin/log_receipts/new')

    click_on 'New Log Receipt'

    expect(page).to have_content('New Log Receipt')

    fill_in 'log_receipt_invoiced_at', with: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    fill_in 'log_receipt_amount', with: Faker::Number.number(digits: 3)
    fill_in 'log_receipt_quantity', with: Faker::Number.number(digits: 3)
    fill_in 'log_receipt_average_weight', with: Faker::Number.number(digits: 3)
    fill_in 'log_receipt_average_diameter', with: Faker::Number.number(digits: 3)
    fill_in 'log_receipt_average_length', with: Faker::Number.number(digits: 3)

    user_select = page.find('#log_receipt_user_id')
    user_select.select(User.last.email)

    click_on 'Create Log receipt'

    expect(old_count).to be < LogReceipt.count
  end
end
