require 'test_helper'

class RumbasClientTest < ActiveSupport::TestCase
  test '#test' do
    assert_equal({:concat_response=>{:value=>"123abc"}}, RumbasClient.test)
  end
end