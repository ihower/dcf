class EntitiesController < ApplicationController

  def index
    donators = Donator.active.page(params[:page]).per(100)

    if params[:order].present? && ["income_amount", "payout_amount"].include?(params[:order])
      donators = donators.order("#{params[:order]} DESC" )
    end

    render :json => donators.map{ |p|
      { :id => p.id,
        :name => p.name,
        :identification => p.identification,
        :transactions_count => p.transactions_count,
        :income_amount => p.income_amount,
        :payout_amount => p.payout_amount,
        :amount => (p.income_amount.to_i - p.payout_amount.to_i),
        :transactions_url => entity_transactions_url(p)
      }
    }, :callback => params['callback']

  end

end
