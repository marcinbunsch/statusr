require File.dirname(__FILE__) + '/../test_helper'

class StatusesControllerTest < ActionController::TestCase
  
  def setup
    login_as(users(:quentin))
  end
  
end
