require "spec_helper"

describe "All Models" do
	let(:p1) { Player.create!(username: "Bob", password: "password", email: "test@test.com") }
	# let(:g1) {}

	context Player do
		it "creates and instance of Player" do
			expect(p1).to be_an_instance_of Player
		end

		it "should require presence of username input" do
      Player.new.should have(1).error_on(:username)
    end

		it "has a collection of Game objects" do
			expect(p1.games.to_a).to be_a_kind_of Array
		end
	end

	context Player

end