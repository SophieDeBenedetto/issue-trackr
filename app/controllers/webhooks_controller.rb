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
    end
  end

  private

    def issue_params
      params["issue"]
    end
end
