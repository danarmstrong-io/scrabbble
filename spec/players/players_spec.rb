require 'spec_helper'

feature 'Player visiting the website' do 
let(:player) { Player.create!(username: "joe", password: "password", email: "joe@joe.com")}
  context "on homepage" do
    it "can log in" do
      visit root_path
      fill_in 'username', with: "joe"
      fill_in 'password', with: "password"
      click_button "Sign In"
      expect(page).to have_content "Welcome"
    end

    it "should have a link that take you to a create player page" do
      visit root_path 
      click_link "Sign Up"
      expect(page).to have_content "email"
    end

    it "can create a new player" do
      visit new_player_path
      fill_in 'Username', with: "bob"
      fill_in 'Email', with: "bob@bob.com"
      fill_in 'Password', with: "aa"
      click_button "Signup"
      expect(page).to have_content "Welcome #{player.username}"
    end

    it "should be able to log out a player" do
      player
      visit root_path
      click_link "logout"
      expect(session[:id]).to be_nil
    end
  end
end