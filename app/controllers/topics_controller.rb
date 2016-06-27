class TopicsController < ApplicationController
  before_action :require_login, except: [:index]
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all.includes(:bookmarks)
  end

  def show
    @topic = Topic.includes(:bookmarks).find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    topic = current_user.topics.new(topic_params)

    if topic.save!
      flash[:notice] = "Topic created successfully!"
      redirect_to topic
    else
      flash.now[:alert] = "There was an issue creating the topic, please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @topic.assign_attributes(topic_params)

    if @topic.save!
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    if @topic.destroy!
      logger.info "deleted"
      flash[:notice] = "Topic was deleted successfully."
      redirect_to topics_path
    else
      logger.info "error <<<<<<<"
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
