require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  it { is_expected.to have_many(:bookmarks) }

  describe "attributes" do
    it "should have title and user_id attributes" do
      expect(topic).to have_attributes(title: topic.title, user_id: user.id)
    end

    it "has title" do
      expect(topic).to respond_to(:title)
    end

    it "has user_id" do
      expect(topic).to respond_to(:user_id)
    end
  end
end
