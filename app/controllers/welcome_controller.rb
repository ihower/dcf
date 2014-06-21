class WelcomeController < ApplicationController

  def index
    render :json => {
      :politicians => "/politicians"
    }
  end

end
