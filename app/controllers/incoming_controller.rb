class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"
		
		user = User.find_by(email: params[:sender])
		puts "USER <<<<<<"
		puts user

		if user 
			puts "FOUND USER"
			topic = Topic.find_or_create_by(title: params[:subject])
			if topic
				puts "FOUND TOPIC"
        Rails.logger.info ">>> Topic: #{topic.inspect}"
				Bookmark.create!(name: params['stripped-text'], url: params['stripped-text'], topic_id: topic.id, user_id: user.id)
			end
		end
    # Assuming all went well.
    head 200
  end
end
