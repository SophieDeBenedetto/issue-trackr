require 'rails_helper'

RSpec.describe Issue, :type => :feature do
  
  describe "#show" do
   before(:each) do 
    @user = User.create(name: "Sophie DeBenedetto", email: "sophie.debenedetto@gmail.com", github_username: "sophiedebenedetto")
     sign_in  
     ApplicationController.any_instance.stub(:current_user).and_return(@user)
   end

    context "without phone number" do 
      it "displays add phone number message" do 
        visit user_path(@user)
        expect(page).to have_content("add your phone number to receive text message updates")
      end
    end

    context "with phone number" do 
      it "displays user's phone number" do 
        @user.update(phone_number: "914-841-4379")
        visit user_path(@user)
        expect(page).to have_content("914-841-4379")
      end
    end
  
  end
end
