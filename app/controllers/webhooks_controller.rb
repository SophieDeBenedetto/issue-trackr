class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def receive
    if params[:zen]
      head :no_content
      return
    else
     binding.pry
    end
  end
end
