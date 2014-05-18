require 'spec_helper'

describe 'Playergame Methods' do
	before :each do
		Tile.create!(letter: "A", value: 1)
		Tile.create!(letter: "P", value: 3)
		Tile.create!(letter: "L", value: 1)
		Tile.create!(letter: "E", value: 1)
		Tile.create!(letter: "P", value: 3)
		Tile.create!(letter: "L", value: 1)
		Tile.create!(letter: "E", value: 1)
		gt1 = Gametile.create!(tile_id: 1)
		gt2 = Gametile.create!(tile_id: 2)
		gt3 = Gametile.create!(tile_id: 3)
		gt4 = Gametile.create!(tile_id: 4)
		gt5 = Gametile.create!(tile_id: 5)
		gt6 = Gametile.create!(tile_id: 6)
		gt7 = Gametile.create!(tile_id: 7)
	end

	context "draw_tile" do
		it "should draw a random tile and assign it to a player_game_id" do
			pg = Playergame.create!
			gt1 = Gametile.create!(tile_id: 1)
			expect(pg.gametiles.count).to eq(0)		
			pg.draw_tile
			expect(pg.gametiles.count).to eq(1)
		end
	end

	context "replenish tiles" do
		it "should replenish 6 tiles if you have 1" do
			pg = Playergame.create!
			gt1 = Gametile.create!(tile_id: 1)
			pg.gametiles << gt1
			expect(pg.gametiles.count).to eq(1)
			pg.replenish_tiles
			expect(pg.gametiles.count).to eq(7)
		end
	
		it "should replenish 1 tile if you have 6" do
			pg = Playergame.create!
			gt1 = Gametile.create!(tile_id: 1)
			gt2 = Gametile.create!(tile_id: 2)
			gt3 = Gametile.create!(tile_id: 3)
			gt4 = Gametile.create!(tile_id: 4)
			gt5 = Gametile.create!(tile_id: 5)
			gt6 = Gametile.create!(tile_id: 6)
			pg.gametiles << [gt1, gt2, gt3, gt4, gt5, gt6]
			expect(pg.gametiles.count).to eq(6)
			pg.replenish_tiles
			expect(pg.gametiles.count).to eq(7)
		end

		it "should replenish 0 tiles if you have 7" do
			pg = Playergame.create!
			gt1 = Gametile.create!(tile_id: 1)
			gt2 = Gametile.create!(tile_id: 2)
			gt3 = Gametile.create!(tile_id: 3)
			gt4 = Gametile.create!(tile_id: 4)
			gt5 = Gametile.create!(tile_id: 5)
			gt6 = Gametile.create!(tile_id: 6)
			gt7 = Gametile.create!(tile_id: 7)
			pg.gametiles << [gt1, gt2, gt3, gt4, gt5, gt6, gt7]
			expect(pg.gametiles.count).to eq(7)
			pg.replenish_tiles
			expect(pg.gametiles.count).to eq(7)
		end
	end

	context "add_to_score" do
		it "should update the playergame score" do
		pg = Playergame.create!
		pg.update_attributes(score: 25)
		expect(pg.score).to eq(25)
		pg.add_to_score(25)
		expect(pg.score).to eq(50)
		end	
	end
end