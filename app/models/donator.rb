class Donator < ActiveRecord::Base

  has_many :transactions

  scope :active, ->{ where("transactions_count > 0") }

end
