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
        :by_providers_url => account_providers_url(a),
        :by_months_url => account_months_url(a)
      }
    }
  end

  def months
    account = Account.find(params[:account_id])
    income_data = account.transactions.income.group("month, year").select("EXTRACT(MONTH from date) as month, EXTRACT(YEAR from date) as year, sum(amount) as total")
    payout_data = account.transactions.payout.group("month, year").select("EXTRACT(MONTH from date) as month, EXTRACT(YEAR from date) as year, sum(amount) as total")

    data = {}
    income_data.each{ |x|
      data[ Date.new(x.year, x.month, 1) ] ||= {}
      data[ Date.new(x.year, x.month, 1) ][:income_total] = x.total
    }

    payout_data.each{ |x|
      data[ Date.new(x.year, x.month, 1) ] ||= {}
      data[ Date.new(x.year, x.month, 1) ][:payout_total] = x.total
    }

    render :json => Hash[ data.sort_by{ |x,y| x } ].each{ |x,y|
      { :date => x,
        :income_total => y[:income_total],
        :payout_total => y[:payout_total]
      }
    }
  end

  def income_codes
    account = Account.find(params[:account_id])
    data = account.transactions.income.group(:code_id).select("code_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      c = Code.find_by_id(x.code_id)

      { :code => c.try(:name),
        :total => x.total,
        :transactions_url => account_transactions_url(account, :code_id => c.try(:id))
      }
    }
  end

  def payout_codes
    account = Account.find(params[:account_id])
    data = account.transactions.payout.group(:code_id).select("code_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      c = Code.find_by_id(x.code_id)

      { :code => c.try(:name),
        :total => x.total,
        :transactions_url => account_transactions_url(account, :code_id => c.try(:id))
      }
    }
  end

  def donators
    account = Account.find(params[:account_id])
    data = account.transactions.income.group(:donator_id).select("donator_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      d = Donator.find_by_id(x.donator_id)

      { :donator => d.try(:name),
        :donator_identification => d.try(:identification),
        :total => x.total,
        :transactions_url => account_transactions_url(account, :entity_id => d.id)
      }
    }
  end

  def providers
    account = Account.find(params[:account_id])
    data = account.transactions.payout.group(:donator_id).select("donator_id, sum(amount) as total")
    render :json => data.sort_by{ |x| x.total || 0 }.reverse.map{ |x|
      d = Donator.find_by_id(x.donator_id)

      { :provider => d.try(:name),
        :provider_identification => d.try(:identification),
        :total => x.total,
        :transactions_url => account_transactions_url(account, :entity_id => d.id)
      }
    }
  end

end
