require "spec_helper"

describe "All Models" do
	let(:p1) { Player.create!(username: "Bob", password: "password", email: "test@test.com") }
	# let(:g1) {}

	context Player do
		it "creates and instance of Player" do
			expect(p1).to be_an_instance_of Player
		end

		it "should raise an ArgumentError if not passed a username" do
      expect{ Player.new() }.should be_valid
    end

		it "has a collection of Game objects" do
			expect(p1.games.all.to_a).to be_a_kind_of Array
		end
	end

end