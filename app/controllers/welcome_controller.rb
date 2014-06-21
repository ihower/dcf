class WelcomeController < ApplicationController

  def index
    render :json => {
      :repository_url => "https://github.com/ihower/dcf",
      :politicians_url => politicians_url,
      :accounts_url => accounts_url,
      :donators_url => donators_url,
      :codes_url => codes_url
    }
  end

end
