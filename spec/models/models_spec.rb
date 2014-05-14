require "spec_helper"

describe Player do
	let(:p1) { Player.create!(username: "Bob", password: "password", email: "test@test.com") }

		it "creates and instance of Player" do
			expect(p1).to be_an_instance_of Player
		end

end