class BookmarksController < ApplicationController
	before_action :require_login
	before_action :set_topic, except: [:create] 	
	before_action :set_bookmark, except: [:new, :create]

	def show
		@bookmark = Bookmark.find(params[:id])
	end

  def new
  	@bookmark = Bookmark.new
	end

	def create
		bookmark = Bookmark.new
		bookmark.topic_id = params[:topic_id]
		bookmark.user_id = current_user.id
		bookmark.assign_attributes(bookmark_params)

		if bookmark.save!
			flash[:notice] = "Bookmark was saved successfully"
			redirect_to [bookmark.topic, bookmark]	
		else
			flash[:notice] = "There was an issue saving the bookmark, please try again"
			render :edit
		end	
	end

  def edit
  end

	def update
		@bookmark.assign_attributes(bookmark_params)

		if @bookmark.save!
				flash[:notice] = "Bookmark was updated"
				redirect_to [@bookmark.topic, @bookmark]
		else
			flash.now[:error] = "Error saving bookmark. Please try again."
			render :edit
		end		
	end

	def destroy
		if @bookmark.destroy!
			flash[:notice] = "Bookmark was deleted"
			redirect_to @topic
		else
			flash[:error] = "Unable to delete bookmark. Please try again"
			render :show
		end
	end
	
	private

	def bookmark_params
		params.require(:bookmark).permit(:name, :url)
	end

	def set_topic
		@topic = Topic.find(params[:topic_id])
	end

	def set_bookmark
		@bookmark = Bookmark.find(params[:id])
	end
end
