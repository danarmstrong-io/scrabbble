require 'spec_helper'

describe 'Gametile Methods' do
	context "put_on_board" do
		it "should remove a playergame id from a gametile" do
			c = Cell.create!
			gt = Gametile.create!(playergame_id: 1)
			expect(gt.playergame_id).to eq(1)
			gt.put_on_board(c)
			expect(gt.playergame_id).to eq(nil)
		end

		it "should assign a cell_id to the gametile" do
			c = Cell.create!
			gt = Gametile.create!(playergame_id: 1)
			expect(gt.cell_id).to eq(nil)
			gt.put_on_board(c)
			expect(gt.cell_id).to eq(c.id)
		end
	end
end