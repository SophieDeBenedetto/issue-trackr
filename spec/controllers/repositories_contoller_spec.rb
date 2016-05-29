require 'rails_helper'

RSpec.describe RepositoriesController, :type => :controller do

  let(:user) { User.create(name: "Sophie DeBenedetto", email: "sophie.debenedetto@gmail.com", github_username: "sophiedebenedetto") }

   before(:each) do 
    allow(controller).to receive(:logged_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
   end
  describe "#create" do
    it "creates a repo with the given link and information requested from github" do
      VCR.use_cassette("create_repo") do 
        expect do
          post :create, {repository: {url: "https://github.com/sophiedebenedetto/learn-write"}}
        end.to change {Repository.count}.from(0).to(1)
        repo = Repository.first
        expect(repo.url).to eq("https://github.com/sophiedebenedetto/learn-write")
        expect(repo.name).to eq("learn-write")
      end
    end

    it "creates the correct number of issues and associates them to the new repository" do 
      VCR.use_cassette("create_repo") do 
         post :create, {repository: {url: "https://github.com/sophiedebenedetto/learn-write"}}
         repo = Repository.first
         expect(repo.issues.count).to eq(2)
         expect(Issue.first.repository).to eq(repo)
         expect(Issue.second.repository).to eq(repo)
       end
    end
  end
end
