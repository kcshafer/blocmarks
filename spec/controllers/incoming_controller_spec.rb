require 'rails_helper'

RSpec.describe IncomingController, type: :controller do
	let(:user) { create(:user) }
	let(:topic) { create(:topic, user_id: user.id) }

	describe "POST #create" do
		before do
			user.update!(email: 'kclshafer@gmail.com')
		end
		
		it "should create bookmark in existing topic" do
				expect{ post :create, {sender: "kclshafer@gmail.com", subject: "NHL", "stripped-text": "www.nhl.com" }}.to change(Bookmark, :count).by(1)
		end

		it "should set name to params['stripped-text']" do
			post :create, {sender: "kclshafer@gmail.com", subject: "NHL", "stripped-text": "www.nhl.com"}
			bookmark = Bookmark.last

			expect(bookmark.name).to eq("www.nhl.com")
		end

		it "should set url to params['stripped-text']" do
			post :create, {sender: "kclshafer@gmail.com", subject: "NHL", "stripped-text": "www.nhl.com"}
			bookmark = Bookmark.last

			expect(bookmark.name).to eq("www.nhl.com")
		end

		it "should create new topic for bookmark" do
			expect{post :create, {sender: "kclshafer@gmail.com", subject: "NHL", "stripped-text": "www.nhl.com"}}.to change(Topic, :count).by(1)
		end
	end
end
