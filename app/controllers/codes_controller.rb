class CodesController < ApplicationController

  def index
    codes = Code.all

    render :json => codes.map{ |c|
      { :id => c.id,
        :name => c.name
      }
    }
  end

end
