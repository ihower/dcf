class TransactionsController < ApplicationController

  def index
    transactions = Transaction.all

    filters = [:politician_id, :account_id, :donator_id, :code_id]
    filters.each do |f|
      transactions = transactions.where( f => params[f] ) if params[f].present?
    end

    render :json => transactions.page(params[:page]).per(100).map{ |t|
      {
        :id => t.id,
        :type => t.transaction_type,
        :date => t.date,
        :donator => t.donator.name,
        :donator_id => t.donator_id,
        :politician => t.politician.try(:name),
        :politician_id => t.politician_id,
        :account => t.account.name,
        :account_id => t.account_id,
        :code => t.code.name,
        :code_id => t.code_id,
        :amount => t.amount,
        :is_money => t.is_money,
        :address => t.address,
        :page => t.page,
        :row => t.row,
        :created_at => t.created_at
      }

    }, :callback => params['callback']
  end

end
