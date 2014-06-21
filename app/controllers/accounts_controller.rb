class AccountsController < ApplicationController

  def index
    accounts = Account.active.all

    render :json => accounts.map{ |a|
      { :id => a.id,
        :name => a.name,
        :transactions_count => a.transactions_count,
        :income_amount => a.income_amount,
        :payout_amount => a.payout_amount,
        :amount => (a.income_amount.to_i - a.payout_amount.to_i)
      }
    }
  end

end
