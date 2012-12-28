class History < ActiveRecord::Base
  belongs_to :user
  attr_accessible :paste
end
