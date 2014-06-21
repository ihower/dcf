class Transaction < ActiveRecord::Base

  belongs_to :account
  belongs_to :politician
  belongs_to :donator
  belongs_to :code

  scope :income, ->{ where(:transaction_type => "income") }
  scope :payout, ->{ where(:transaction_type => "payout") }

  default_scope ->{ order("date DESC, id DESC") }

end
