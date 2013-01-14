class User < ActiveRecord::Base
  attr_accessible :email, :first, :last, :login, :password_digest, :password_hash, :password_salt, :password, :password_confirmation, :ouser_id

  has_secure_password

  validates :password, :presence => true, :on => :create
  validates_uniqueness_of :email
end

