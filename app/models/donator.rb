class Donator < ActiveRecord::Base

  has_many :transactions

end
