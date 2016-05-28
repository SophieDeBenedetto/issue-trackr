class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def receive
    if params[:zen]
      head :no_content
      return
    else
      issue = Issue.find_or_create_by(url: issue_params["html_url"])
      if !issue.repository
        url_elements= issue_params["repository_url"].split("/")
        repo_url = "https://github.com/#{url_elements[-2]}/#{url_elements[-1]}"
        repo = Repository.find_by(url: repo_url)
        issue.update(repository: repo)
      end
      issue.update(title: issue_params["title"], content: issue_params["body"], assignee: issue_params["assignee"], status: issue_params["state"])
      owner = issue.repository.user
      if owner.phone_number
        @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
        @client.messages.create(
          to: owner.phone_number, 
          from: "+1 #{ENV['TWILIO_NUMBER']}",
           body: "#{issue.title} has been updated. View it here: #{issue.url}")
      end
      UserMailer.issue_update_email(issue.user, issue).deliver_now
      head :no_content
      return
    end
  end

  private

    def issue_params
      params["issue"]
    end
end
