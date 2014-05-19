require 'spec_helper'

describe 'Game Methods' do
	context "self.pending" do
		it "should return a collection of pending games" do
			g1 = Game.create!
			g2 = Game.create!
			g2.update_attributes(status: "active")
			expect(Game.pending).to eq([g1])
		end
	end

	context "self.dimension" do
		it "should define the dimensoin of the game board" do
			expect(Game.dimension).to eq(15)
		end
	end

	context "self.calculate_score" do
		before :each do
			Tile.create!(letter: "A", value: 1)
			Tile.create!(letter: "P", value: 3)
			Tile.create!(letter: "L", value: 1)
			Tile.create!(letter: "E", value: 1)
		end

		it "should calculate the score of a word" do
			expect(Game.calculate_score("APPLE")).to eq(9)
		end
	
		it "should calculate the score of multiple words" do
			expect(Game.calculate_score("APE-APPLE")).to eq(14)
		end
	end

	context "tiles_remaining" do
		it "should the count of the remaining gametiles" do
			g1 = Game.create!
			5.times do 
				g1.gametiles << Gametile.create!
			end
			expect(g1.tiles_remaining).to eq(5)
		end
	end

	context "find_cell_letter" do
		it "should determine the letter of a cell based on a grid location" do
			g = Game.create!
			c = Cell.create!(x_coord: 1, y_coord: 1)
			t = Tile.create!(letter: "A")
			gt = Gametile.create!(game: g, cell: c, tile: t)
			expect(g.find_cell_letter(1,1)).to eq("A")
		end

		it "should return nil if no letter is in a cell" do
			g = Game.create!
			c = Cell.create!(x_coord: 2, y_coord: 2)
			gt = Gametile.create!(game: g, cell: c)
			# expect(g.find_cell_letter(2,2)).to eq(nil)
		end
	end

	context "change_turn" do
		it "should change the turn of the current player (last)" do
			g = Game.create!
			p1 = Player.create!(username: "p1")
			p2 = Player.create!(username: "p2")
			pg1 = Playergame.create!(game: g, player: p1)
			pg2 = Playergame.create!(game: g, player: p2)
			g.current_player_id = p1.id
			g.change_turn
			expect(g.current_player_id).to eq(p2.id)
		end
	end

	context "start" do
		it "should set the game status to active" do
			g = Game.create!
			p1 = Player.create!(username: "p1")
			p2 = Player.create!(username: "p2")
			pg1 = Playergame.create!(game: g, player: p1)
			pg2 = Playergame.create!(game: g, player: p2)
			g.start
			expect(g.status).to eq("active")
		end

		it "should set 7 Gametiles to each playergame" do
			g = Game.create!
			p1 = Player.create!(username: "p1")
			p2 = Player.create!(username: "p2")
			pg1 = Playergame.create!(game: g, player: p1)
			pg2 = Playergame.create!(game: g, player: p2)
			14.times do
				Gametile.create!(game: g)
			end
			g.start
			expect(pg1.gametiles.count).to eq(7)
		end
	end

	context "complete" do
		it "should set the game status to completed" do
			g = Game.create!
			g.status = "active"
			g.complete
			expect(g.status).to eq("completed")		
		end
	end
end