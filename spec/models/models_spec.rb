require "spec_helper"

# CODE REVIEW: What made you decide to put the tests for all models in 1 file?
describe "All Models -" do
	let(:p1) { Player.create!(username: "Bob", password: "password", email: "test@test.com") }
	let(:g1) { Game.create! }

	context Player do
		it "creates and instance of Player" do
			expect(p1).to be_an_instance_of Player
		end

		it "should require presence of username input" do
      Player.new.should have(1).error_on(:username)
    end

		it "should have a collection of Game objects" do
			expect(p1.games.to_a).to be_a_kind_of Array
		end
	end

	context Game do
		it "has a collection of gametiles" do
			expect(g1.gametiles.to_a).to be_a_kind_of Array
		end

		it "has a collection of players through player games" do
			expect(g1.players.to_a).to be_a_kind_of Array
		end

		it "defaults status to pending after save" do
			expect(g1.status).to eq "pending"
		end
	end

	context Playergame do
		it "belongs to a Player" do
			pg1 = p1.playergames.create!
			expect(pg1.player.username).to eq "Bob"
		end

		it "belongs to a Game" do
			pg1 = g1.playergames.create!
			g1_id = g1.id
			expect(pg1.game.id).to eq g1_id
		end

	end

	context Gametile do
		it "belongs to a game"

		it "belongs to a cell"

		it "belongs to a tile"

		it "belongs to a playergame"

		it "defaults to a tile value of nil" 

		it "requires a cell at creation"

	end

end