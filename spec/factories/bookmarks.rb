FactoryGirl.define do
  factory :bookmark do
    url "www.google.com"
    name "Google"
		user
		topic
  end
end
