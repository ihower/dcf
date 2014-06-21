class Transaction < ActiveRecord::Base

  belongs_to :account
  belongs_to :politician
  belongs_to :donator
  belongs_to :code

end
