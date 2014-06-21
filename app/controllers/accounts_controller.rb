class AccountsController < ApplicationController

  def index
    accounts = Account.active.all

    render :json => accounts.map{ |a|
      { :id => a.id,
        :name => a.name,
        :transactions_count => a.transactions_count,
        :income_amount => a.income_amount,
        :payout_amount => a.payout_amount,
        :amount => (a.income_amount.to_i - a.payout_amount.to_i),
        :by_incomes_url => account_income_codes_url(a),
        :by_payouts_url => account_payout_codes_url(a),
        :by_donators_url => account_donators_url(a),
        :by_companies_url => account_companies_url(a)
      }
    }
  end

  def income_codes
    account = Account.find(params[:account_id])
    data = account.transactions.income.group(:code_id).select("code_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      { :code => Code.find_by_id(x.code_id).try(:name),
        :total => x.total
      }
    }
  end

  def payout_codes
    account = Account.find(params[:account_id])
    data = account.transactions.payout.group(:code_id).select("code_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      { :code => Code.find_by_id(x.code_id).try(:name),
        :total => x.total
      }
    }
  end

  def donators
    account = Account.find(params[:account_id])
    data = account.transactions.income.group(:donator_id).select("donator_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      { :donator => Donator.find_by_id(x.donator_id).try(:name),
        :total => x.total
      }
    }
  end

  def companies
    account = Account.find(params[:account_id])
    data = account.transactions.payout.group(:donator_id).select("donator_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      { :company => Donator.find_by_id(x.donator_id).try(:name),
        :total => x.total
      }
    }
  end

end
