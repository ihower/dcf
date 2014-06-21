class PoliticiansController < ApplicationController

  def index
    politicians = Politician.active.all

    render :json => politicians.map{ |p|
      { :id => p.id,
      :name => p.name,
      :transactions_count => p.transactions_count,
      :income_amount => p.income_amount,
      :payout_amount => p.payout_amount,
      :amount => (p.income_amount.to_i - p.payout_amount.to_i),
      :accounts => p.accounts.map{ |a|
        {
          :id => a.id,
          :name => a.name,
          :transactions_count => a.transactions_count,
          :income_amount => a.income_amount,
          :payout_amount => a.payout_amount,
          :amount => (a.income_amount.to_i - a.payout_amount.to_i),
        }
      }
      }
    }
  end

end
