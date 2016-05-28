class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def receive
    if params[:zen]
      head :no_content
      return
    else
      issue = Issue.find_or_create_by(url: issue_params["html_url"])
      issue.update(title: issue_params["title"], content: issue_params["body"], assignee: issue_params["assignee"], status: issue_params["state"])
      owner = issue.repository.user
      if owner.phone_number
        @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
        @client.messages.create(
          to: owner.phone_number, 
          from: "+1 #{ENV['TWILIO_NUMBER']}",
           body: "#{issue.name} has been updated. View it here: #{issue.url}")
      end
    end
  end

  private

    def issue_params
      params["issue"]
    end
end
