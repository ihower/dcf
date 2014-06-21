class WelcomeController < ApplicationController

  def index
    render :json => {
      :politicians_url => politicians_url,
      :accounts_url => accounts_url,
      :entities_url => entities_url,
      :entities_by_income_url => entities_url( :order => "income_amount" ),
      :entities_by_payout_url => entities_url( :order => "payout_amount" ),
      :codes_url => codes_url,
      :repository_url => "https://github.com/ihower/dcf"
    }
  end

end
