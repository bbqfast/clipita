class User < ActiveRecord::Base
  attr_accessible :email, :first, :last, :login, :password_digest, :password_hash, :password_salt
   validates_uniqueness_of :email



end
