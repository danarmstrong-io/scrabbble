require "spec_helper"

describe "All Model -" do
	let(:p1) { Player.create!(username: "Bob", password: "password", email: "test@test.com") }
	let(:g1) { Game.create! }

	context Player do
		it "should require presence of username input" do
      Player.new.should have(1).error_on(:username)
    end

		it "should have a collection of Game objects" do
			expect(p1).to respond_to(:games)
		end

		it "should have a collection of won games" do
			expect(p1).to respond_to(:wins)
		end

		it "should have a collection of current games" do
			expect(p1).to respond_to(:current_games)
		end

	end

	context Game do
		it "should have a collection of gametiles" do
			expect(g1).to respond_to(:gametiles)
		end

		it "should have a collection of players through player games" do
			expect(g1).to respond_to(:players)
		end 

		it "should have a current player" do
			expect(g1).to respond_to(:current_player)
		end 

		it "should have a collection of gametiles" do
			expect(g1).to respond_to(:gametiles)
		end 

		it "should have a winner" do
			expect(g1).to respond_to(:winner)
		end 

		it "defaults status to pending after save" do
			expect(g1.status).to eq "pending"
		end
	end

	context Playergame do
		let(:pg1) { Playergame.create! }
		it "belongs to a Player" do
			expect(pg1).to respond_to(:player)
		end

		it "belongs to a Game" do
			expect(pg1).to respond_to(:game)
		end

	end

	context Gametile do
		let(:gt1) { Gametile.create(cell_id: 1)}
		it "belongs to a game" do
			expect(gt1).to respond_to(:game)
		end 

		it "belongs to a cell" do
			expect(gt1).to respond_to(:cell)
		end 

		it "belongs to a tile" do
			expect(gt1).to respond_to(:tile)
		end

		it "belongs to a playergame" do
			expect(gt1).to respond_to(:playergame)
		end

		it "defaults to a tile value of nil" do
			expect(gt1.tile_id).to eq nil	
		end

		it "requires a cell at creation" do
			Gametile.new.should have(1).error_on(:cell_id)
		end
	end

	context Tile do
		it "should have a collection of gametiles" do
			expect(Tile.new).to respond_to(:gametiles)
		end
	end

	context Cell do
		it "should have a collection of gametiles" do
			expect(Cell.new).to respond_to(:gametiles)
		end
	end
end