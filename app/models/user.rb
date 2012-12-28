class User < ActiveRecord::Base
  attr_accessible :email, :first, :last, :login, :password_digest, :password_hash, :password_salt
end
