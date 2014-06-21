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
      :transactions_url => politician_transactions_url(p),
      :accounts => p.accounts.active.map{ |a|
        {
          :id => a.id,
          :name => a.name,
          :transactions_count => a.transactions_count,
          :income_amount => a.income_amount,
          :payout_amount => a.payout_amount,
          :amount => (a.income_amount.to_i - a.payout_amount.to_i),
          :transactions_url => account_transactions_url(a),
          :by_incomes_url => account_income_codes_url(a),
          :by_payouts_url => account_payout_codes_url(a),
          :by_donators_url => account_donators_url(a),
          :by_companies_url => account_companies_url(a)
        }
      }
      }
    }, :callback => params['callback']
  end

end
