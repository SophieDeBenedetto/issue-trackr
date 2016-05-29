class RepositoriesController < ApplicationController

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = Repository.find(params[:id])
    if @repository.user == current_user
      render :show
    else
      redirect_to root_path, notice: "you can only view your own repos!"
    end
  end

  def create
    @client ||= Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
    repo_owner = params[:repository][:url].split("/")[-2]
    repo_name = params[:repository][:url].split("/")[-1]
    @repo = Repository.new(name: repo_name, url: params[:repository][:url], user: current_user)
    if @repo.save
      gh_repo = @client.repo("#{repo_owner}/#{repo_name}")
      @client.issues("#{repo_owner}/#{repo_name}").each do |issue|
        Issue.create(url: issue.html_url, opened_by: issue.user.login, status: issue.state, title: issue.title, content: issue.body, opened_on: issue.created_at, assignee: issue.assignee, repository: @repo)
      end
      @client.create_hook("#{repo_owner}/#{repo_name}",
        'web',
        {url: "#{ENV['ISSUE_TRACKR_APP_URL']}/webhooks/receive", content_type: 'json'},
        {events: ['issues'], active: true})
    end
    respond_to do |f|
      f.js
      f.html {head :no_content; return}
    end
  end
end

