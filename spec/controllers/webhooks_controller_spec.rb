require 'rails_helper'

RSpec.describe WebhooksController, :type => :controller do

  FIXTURES_PATH = Rails.root.join("spec", "fixtures")


  describe "#receive" do
    before(:each) do 
      @user = User.create(name: "Sophie DeBenedetto", email: "sophie.debenedetto@gmail.com", github_username: "SophieDeBenedetto")
    end
    
    context "with a new issue" do 
      it "creates a new issue with the info in the payload from github" do
       VCR.use_cassette("webooks_receive") do 
          payload = JSON.parse(File.read("#{FIXTURES_PATH }/webhook_issue_payload.json"), symbolize_names: true)
          repo = Repository.create(name: "learn-write", url: "https://github.com/SophieDeBenedetto/learn-write", user: @user)
          post :receive, payload
          issue = Issue.first
          expect(repo.issues.count).to eq(1)
          expect(issue.url).to eq("https://github.com/SophieDeBenedetto/learn-write/issues/5")
          expect(issue.repository).to eq(repo)
          expect(issue.user).to eq(@user)
        end
      end
    end

    context "updating an existing issue" do 
      it "updates an existing issue with the info in the payload from github" do
        repo = Repository.create(name: "learn-write", url: "https://github.com/SophieDeBenedetto/learn-write", user: @user)
        repo.issues.build(url: "https://github.com/SophieDeBenedetto/learn-write/issues/5", content: "testing")
        payload = JSON.parse(File.read("#{FIXTURES_PATH }/webhook_issue_payload.json"), symbolize_names: true)
        post :receive, payload
        expect(repo.issues.count).to eq(1)
        expect(repo.issues.first.content).to eq("THIS IS a TEST")
      end
    end
  end
end
