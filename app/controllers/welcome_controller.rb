class WelcomeController < ApplicationController

  def index
    render :json => {
      :repository => "https://github.com/ihower/dcf",
      :politicians => "/politicians"
    }
  end

end
