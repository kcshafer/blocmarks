require 'faker'

#users
5.times do
	User.create!(
		email: Faker::Internet.email,
		password: Faker::Internet.password(8)
	)
end

users = User.all

#topics
10.times do
	Topic.create!(
		title: Faker::Lorem.word,
		user: users.sample
	)	
end

topics = Topic.all

#bookmarks
20.times do
	Bookmark.create!(
		name: Faker::Lorem.word,
		url: Faker::Internet.url,
		user_id: users.sample.id,
		topic: topics.sample
	)
end
