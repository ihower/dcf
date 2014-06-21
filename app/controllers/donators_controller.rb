class DonatorsController < ApplicationController

  def index
    donators = Donator.active.page(params[:page]).per(100)

    render :json => donators.map{ |p|
      { :id => p.id,
        :name => p.name,
        :transactions_count => p.transactions_count,
        :income_amount => p.income_amount,
        :payout_amount => p.payout_amount,
        :amount => (p.income_amount.to_i - p.payout_amount.to_i)
      }
    }

  end

end
