require 'rails_helper'

RSpec.describe Users::Products::BidCreator, type: :service do
  describe '.call' do
    let!(:owner) { User.create(name: 'Owner', email: 'owner@owner.com', password: 'password') }
    let!(:bidder) { User.create(name: 'Bidder', email: 'bidder@bidder.com', password: 'password', money: 200.0) }
    let!(:product) { Product.create(name: 'Book', min_price: 120, user: owner) }

    let!(:old_bidder) { User.create(name: 'Old Bidder', email: 'old@bidder.com', password: 'password', money: 100.0) }
    let!(:old_bid) { product.bids.create(user: old_bidder, amount: 130) }

    context 'valid params' do
      let(:bid_amount) { 150 }

      it 'creates a bid on a product' do
        bid = product.bids.new(user: bidder, amount: bid_amount)
        response = Users::Products::BidCreator.new(bid, bid_amount, bidder).call

        bid = Bid.last
        expect(response).to be true
        expect(product.reload.current_bid).to eq bid
        expect(bidder.reload.money).to eq 200 - 150
      end

      context 'raising your bid' do
        let!(:previous_bid) { product.bids.create(user: bidder, amount: 145) }

        it 'takes only the new amount of money from your account' do
          bid = product.bids.new(user: bidder, amount: bid_amount)
          response = Users::Products::BidCreator.new(bid, bid_amount, bidder).call

          bid = Bid.last
          expect(response).to be true
          expect(product.reload.current_bid).to eq bid
          expect(bidder.reload.money).to eq 200 - 5
        end
      end

      context 'previous bidder' do
        it 'creates a new highest bid and shuffles money' do
          bid_amount = 150
          bid = product.bids.new(user: bidder, amount: bid_amount)
          response = Users::Products::BidCreator.new(bid, bid_amount, bidder).call

          bid = Bid.last
          expect(response).to be true
          expect(product.bids.count).to be 2
          expect(product.reload.current_bid).to eq bid
          expect(bidder.reload.money).to eq 200 - 150
          expect(old_bidder.reload.money).to eq 100 + old_bid.amount
        end
      end
    end

    context 'invalid params' do
      context 'user outbid' do
        it 'returns false if bid was too low' do
          bid_amount = 125
          bid = product.bids.new(user: bidder, amount: bid_amount)
          response = Users::Products::BidCreator.new(bid, bid_amount, bidder).call

          expect(response).to be false
          expect(product.bids.count).to be 1
          expect(product.reload.current_bid).to eq old_bid
        end
      end

      context 'bid below min_price of product' do
        it 'returns false' do
          product.update(min_price: 300)
          product.bids.destroy_all
          bid_amount = 125
          bid = product.bids.new(user: bidder, amount: bid_amount)
          response = Users::Products::BidCreator.new(bid, bid_amount, bidder).call

          expect(response).to be false
          expect(product.bids.count).to be 0
          expect(bid.errors.messages[:amount].first).to eq 'Minimum bid for this item is €300.0'
          expect(bidder.money).to eq 200
        end
      end
    end
  end
end
