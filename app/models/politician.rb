class Politician < ActiveRecord::Base

  has_many :accounts
  has_many :transactions

end
