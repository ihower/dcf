class WelcomeController < ApplicationController

  def index
    render :json => {
      :politicians_url => politicians_url,
      :accounts_url => accounts_url,
      :entities_url => entities_url,
      :codes_url => codes_url,
      :repository_url => "https://github.com/ihower/dcf"
    }
  end

end
