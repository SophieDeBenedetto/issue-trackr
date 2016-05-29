require 'rails_helper'

RSpec.describe WebhooksController, :type => :controller do

  FIXTURES_PATH = Rails.root.join("spec", "fixtures")
      let(:user) { User.create(name: "Sophie DeBenedetto", email: "sophie.debenedetto@gmail.com", github_username: "sophiedebenedetto") }
      let(:repo) { Repository.create(name: "learn-write", url: "https://github.com/sophiedebenedetto/learn-write", user: user) }
  
  describe "#receive" do
    
    context "with a new issue" do 
      xit "updates issues with the info in the payload from github" do
       VCR.user_cassette("webooks_receive") do 
          payload = JSON.parse(File.read(FIXTURES_PATH + "/webhook_issue_payload.json"))
          post :receive, payload
          issue = Issue.first
          expect(repo.issues.count).to eq(1)
          expect(issue.url).to eq("https://github.com/sophiedebenedetto/learn-write/issues/1")
          expect(issue.repository).to eq(repo)
        end
      end
    end
  end
end
