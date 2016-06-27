require 'rails_helper'
require 'faker'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic) }
  
  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has url and topic id attributes" do
      expect(bookmark).to have_attributes(url: bookmark.url, topic_id: topic.id)
    end

    it "has url" do
      expect(bookmark).to respond_to(:url)
    end

    it "has topic_id" do
      expect(bookmark).to respond_to(:topic_id)
    end
  end
end
