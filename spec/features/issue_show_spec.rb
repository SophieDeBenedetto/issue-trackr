require 'rails_helper'

RSpec.describe Issue, :type => :feature do
  
  describe "#show" do
   before(:each) do 
    @user = User.create(name: "Sophie DeBenedetto", email: "sophie.debenedetto@gmail.com", github_username: "sophiedebenedetto")
    @repo = Repository.create(name: "learn-write", url: "https://github.com/SophieDeBenedetto/learn-write", user: @user)
    @issue = Issue.create(title: "my issue", content: "this is a test issue.", repository: @repo, opened_on: DateTime.now, url: "https://github.com/SophieDeBenedetto/learn-write/issues/1")
     sign_in  
     ApplicationController.any_instance.stub(:current_user).and_return(@user)
   end

    it "displays an issues's title, content, github link and repo name" do
      visit issue_path(@issue)
      expect(page).to have_content("my issue")
      expect(page).to have_content("this is a test issue.")
      expect(page).to have_content("view on github")
      expect(page).to have_content("Learn Write")
    end

    context "without an assignee" do 
      it "displays 'n/a' for the assignee atttribute" do
        visit issue_path(@issue)
        expect(page).to have_content("assignee: n/a") 
      end
    end

    context "with an assignee" do 
      it "displays the name of the person assigned for the assignee atttribute" do
        @issue.assignee = "antoinfive"
        @issue.save
        visit issue_path(@issue)
        expect(page).to have_content("assignee: antoinfive") 
      end
    end
  
  end
end
