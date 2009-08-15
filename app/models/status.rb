class Status < ActiveRecord::Base
  
  belongs_to :user
  
  attr_accessor :user_id
    
end
