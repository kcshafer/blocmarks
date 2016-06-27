require 'rails_helper'
require 'faker'

RSpec.describe TopicsController, type: :controller do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user_id: user.id) }

  context "unauthenticated user" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "should assign Topic.all to topics" do
        get :index
        expect(assigns(:topics)).to eq([topic])
      end
    end

    describe "GET #show" do
      it "returns redirect to login" do
        get :show, { id: topic.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #new" do
      it "returns redirect to login" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "returns redirect to login" do
        get :edit, { id: topic.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "authenticated user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do 
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "should assign Topic.all to topics" do
        get :index
        expect(assigns(:topics)).to eq([topic])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, { id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, { id: topic.id }
        expect(response).to render_template(:show)
      end

      it "should assign topic to @topic" do
        get :show, { id: topic.id }
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "initializes @topic" do
        get :new
        expect(assigns(:topic)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increases the number of topics by 1" do
        expect{ post :create, { topic: { title: "Test Topic"} }}.to change(Topic, :count).by(1)    
      end

      it "redirects to new topic" do
        post :create, { topic: { title: "Test Topic" }}
        expect(response).to redirect_to(Topic.last)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, { id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, { id: topic.id }
        expect(response).to render_template(:edit)
      end

      it "assigns topic to @topic" do
        get :edit, { id: topic.id }
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "PUT #update" do
      it "updates topic with new values" do
        new_title = Faker::Lorem.word

        put :update, id: topic.id, topic: { title: new_title }

        updated_topic = assigns(:topic)

        expect(updated_topic.title).to eq(new_title)
      end

      it "redirects to updated topic" do
        new_title = Faker::Lorem.word

        put :update, id: topic.id, topic: { title: new_title }
      
        expect(response).to redirect_to(topic)
      end
    end
    
    describe "DELETE #destroy" do
      it "deletes the topic" do
        delete :destroy, { id: topic.id }
        count = Topic.where({id: topic.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic index" do
        delete :destroy, { id: topic.id }
        expect(response).to redirect_to(topics_path)
      end
    end
  end
end
