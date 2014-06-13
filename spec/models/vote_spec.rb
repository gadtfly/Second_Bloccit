require 'rails_helper'

describe Vote  do

  describe "up_vote?" do
    it "returns true for an up vote" do
      v = Vote.new(value: 1)
      expect( v.up_vote? ).to eq true #changed == to eq since it didnt work (stackoverflow)
    end
    it "returns false for a down vote" do
      v = Vote.new(value: -1)
      expect( v.up_vote? ).to eq false #changed == to eq since it didnt work (stackoverflow)
    end
  end

  describe "down_vote?" do
    it "returns true for a down vote" do
      v = Vote.new(value: -1)
      expect( v.down_vote? ).to eq true #changed == to eq since it didnt work (stackoverflow)
    end
    it "returns false for a up vote" do
      v = Vote.new(value: 1)
      expect( v.down_vote? ).to eq false #changed == to eq since it didnt work (stackoverflow)
    end
  end

    describe "#update_post" do
      it "calls `update_rank` on post" do
        post = create(:post)
        expect(post).to receive(:update_rank)
        expect(post).to respond_to(:update_rank)
        Vote.create(value: 1, post: post)
      end
    end
end