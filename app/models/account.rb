class Account < ActiveRecord::Base

  belongs_to :politician
  has_many :transactions

  scope :active, ->{ where("transactions_count > 0") }

end
