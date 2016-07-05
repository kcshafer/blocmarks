require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
	let(:user) { create(:user)}
	let(:topic) { create(:topic, user_id: user.id) }
	let(:bookmark) { create(:bookmark, user_id: user.id, topic_id: topic.id) }

	context "unauthenticated user" do
  	describe "GET #show" do
    	it "redirects to login path" do
				get :show, {id: bookmark.id, topic_id: topic.id}
      	expect(response).to redirect_to(new_user_session_path)
    	end
  	end

  	describe "GET #new" do
    	it "redirects to login path" do
				get :new, { topic_id: topic.id }
    		expect(response).to redirect_to(new_user_session_path)
			end
  	end

		describe "POST #create" do
			it "redirects to login path" do
				post :create, { topic_id: topic.id }
				expect(response).to redirect_to(new_user_session_path)
			end
		end

  	describe "GET #edit" do
   		it "redirects to login path" do
				get :edit, { id: bookmark.id, topic_id: topic.id }
				expect(response).to redirect_to(new_user_session_path)
    	end
  	end

		describe "PUT #update" do
			it "redirects to login path" do
				put :update, { id: bookmark.id, topic_id: topic.id }
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "DELETE #destroy" do
			it "redirects to login path" do
				delete :destroy, { id: bookmark.id, topic_id: topic.id }
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	context "authenticated user" do
		before do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			sign_in user
		end
					
		describe "GET #show" do
			it "returns http success" do
				get :show, { id: bookmark.id, topic_id: topic.id }
				expect(response).to have_http_status(:success)
			end
			
			it "renders the show view" do
				get :show, { id: bookmark.id, topic_id: topic.id}
				expect(response).to render_template(:show)
			end

			it "assigns bookmark to @bookmark" do
				get :show, { id: bookmark.id, topic_id: topic.id }
				expect(assigns(:bookmark)).to eq(bookmark)	
			end

			it "assigns topic to @topic" do
				get :show, { id: bookmark.id, topic_id: topic.id }
				expect(assigns(:topic)).to eq(topic)
			end
		end
		
		describe "GET #new" do
			it "returns http success" do
				get :new, { topic_id: topic.id }
				expect(response).to have_http_status(:success)
			end

			it "renders the new view" do
				get :new, { topic_id: topic.id }
				expect(response).to render_template(:new)
			end

			it "initliazes @bookmark" do
				get :new, { topic_id: topic.id }
				expect(:bookmark).to_not be_nil
			end

			it "assigns topic to @topic" do
				get :new, { topic_id: topic.id }
				expect(assigns(:topic)).to eq(topic)
			end
		end

		describe "POST #create" do
			it "increases the number of bookmarks by 1" do
				expect{ post :create, { "topic_id": topic.id, bookmark: { name: "Google", url: "www.google.com" }}}.to change(Bookmark, :count).by(1)
			end

			it "redirects to new topic" do
				post :create, { "topic_id": topic.id, bookmark: { name: "Google", url: "www.google.com" }}
				expect(response).to redirect_to([topic, Bookmark.last])	
			end
		end

		describe "GET #edit" do
			it "returns http success" do
				get :edit, {id: bookmark.id, topic_id: topic.id}
				expect(response).to have_http_status(:success)
			end

			it "renders the edit view" do
				get :edit, {id: bookmark.id, topic_id: topic.id}
				expect(response).to render_template(:edit)
			end

			it "assigns bookmark to @bookmark" do
				get :edit, {id: bookmark.id, topic_id: topic.id}
				expect(assigns(:bookmark)).to eq(bookmark)
			end

			it "assigns topic to @topic" do
				get :edit, {id: bookmark.id, topic_id: topic.id}
				expect(assigns(:topic)).to eq(topic)
			end
		end

		describe "PUT #update" do
			it "updates topic with new values" do
				new_url = Faker::Internet.url
				new_name = Faker::Lorem.word

				put :update, {id: bookmark.id, topic_id: topic.id, bookmark: {name: new_name, url: new_url}}
				updated_bookmark = assigns(:bookmark)

				expect(updated_bookmark.name).to eq(new_name)
				expect(updated_bookmark.url).to eq(new_url)
			end

			it "redirects to updated bookmark" do
				put :update, {id: bookmark.id, topic_id: topic.id, bookmark: {name: "Updated Name", url: "newurl.com"}}

				expect(response).to redirect_to([topic, bookmark])
			end
		end

		describe "DELETE #destroy" do
			it "deletes the bookmark" do
				delete :destroy, {id: bookmark.id, topic_id: topic.id}

				expect(Bookmark.where(id: bookmark.id).size).to eq(0)
			end

			it "redirects to bookmark topic" do
				delete :destroy, {id: bookmark.id, topic_id: topic.id}
				expect(response).to redirect_to(topic)
			end
		end
	end
end
