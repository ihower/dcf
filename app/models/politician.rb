class Politician < ActiveRecord::Base

  has_many :accounts
  has_many :transactions

  scope :active, ->{ where("transactions_count > 0") }
end
