class Transaction < ActiveRecord::Base

  belongs_to :account
  belongs_to :politician
  belongs_to :donator
  belongs_to :code

  scope :outcome, ->{ where(:transaction_type => "outcome") }
  scope :payout, ->{ where(:transaction_type => "payout") }

end
