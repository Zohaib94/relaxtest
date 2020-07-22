# frozen_string_literal: true

require 'test_helper'

class LogReceiptsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get log_receipts_index_url
    assert_response :success
  end
end
