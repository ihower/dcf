class Account < ActiveRecord::Base

  belongs_to :politician
  has_many :transactions

end
