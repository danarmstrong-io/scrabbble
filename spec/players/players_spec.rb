require 'spec_helper'

feature 'Player visiting the website' do 
let(:player) { Player.create!(username: "joe", password_digest: "aa", email: "joe@joe.com")}
  context "on homepage" do
    it "can log in" do
      visit create_session_path
      fill_in 'username', with: "joe"
      fill_in 'password', with: "aa"
      click_button "Login"
      expect(page).to have_content "Welcome #{player.username}"
    end

    it "can log out" do
      player
      visit show_player_path
      click_button "Logout"
      expect(session[:id]).to be_nil
    end
    
    it "can create a new player" do
      visit create_player_path
      fill_in 'username', with: "bob"
      fill_in 'email', with: "bob@bob.com"
      fill_in 'password', with: "aa"
      click_button "Signup"
      expect(page).to have_content "Welcome #{player.username}"
    end

  end

end