require 'spec_helper'

feature 'Player visiting the website' do 
let(:player) { Player.create!(username: "joe", password_digest: "aa", email: "joe@joe.com")}
  context "on homepage" do
    before(:all) do
              # Seed Tiles for scrabbble game
        # E
        12.times { Tile.create!(letter: 'E', value: 1) }
        # A, I
        9.times { Tile.create!(letter: 'A', value: 1)
                  Tile.create!(letter: 'I', value: 1) }
        # O
        8.times { Tile.create!(letter: 'O', value: 1) }
        # N, R, T
        6.times { Tile.create!(letter: 'N', value: 1)
                  Tile.create!(letter: 'R', value: 1)
                  Tile.create!(letter: 'T', value: 1) }
        # L, S, U, D
        4.times { Tile.create!(letter: 'L', value: 1)
                  Tile.create!(letter: 'S', value: 1)
                  Tile.create!(letter: 'U', value: 1)
                  Tile.create!(letter: 'D', value: 2) }
        # G
        3.times { Tile.create!(letter: 'G', value: 2) }
        # B, C, M, P, F, H, V, W, Y
        2.times { Tile.create!(letter: 'B', value: 3)
                  Tile.create!(letter: 'C', value: 3)
                  Tile.create!(letter: 'M', value: 3)
                  Tile.create!(letter: 'P', value: 3)
                  Tile.create!(letter: 'F', value: 4)
                  Tile.create!(letter: 'H', value: 4)
                  Tile.create!(letter: 'V', value: 4)
                  Tile.create!(letter: 'W', value: 4)
                  Tile.create!(letter: 'Y', value: 4) }
        # K, J, X, Q, Z
                  Tile.create!(letter: 'K', value: 5)
                  Tile.create!(letter: 'J', value: 8)
                  Tile.create!(letter: 'X', value: 8)
                  Tile.create!(letter: 'Q', value: 10)
                  Tile.create!(letter: 'Z', value: 10)
      end
    it "can log in" do
      visit root_path
      click_link "signin"
      fill_in 'username', with: "joe"
      fill_in 'password', with: "aa"
      expect(session[:id]).not_to be_nil
    end

    it "can log out" do
      player
      visit root_path
      click_link "logout"
      expect(session[:id]).to be_nil
    end
    
    it "can create a new player" do
      visit new_player_path
      fill_in 'username', with: "bob"
      fill_in 'email', with: "bob@bob.com"
      fill_in 'password', with: "aa"
      click_button "Signup"
      expect(page).to have_content "Welcome #{player.username}"
    end

  end

end