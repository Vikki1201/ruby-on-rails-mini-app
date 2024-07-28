require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { User.create(username: "testuser", email: "test@example.com", first_name: "Test", last_name: "User") }
  let!(:existing_post) { Post.create(content: "This is a test post", user: user) }

  describe "POST /posts" do
    it "creates a new post" do
      post_params = { content: "Another test post", user_id: user.id }
      post "/posts", params: { post: post_params }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["content"]).to eq("Another test post")
    end
  end

  describe "GET /posts" do
    it "lists all posts" do
      get "/posts"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["content"]).to eq("This is a test post")
    end
  end

  describe "PUT /posts/:id" do
    it "updates a post" do
      put_params = { content: "Updated test post" }
      put "/posts/#{existing_post.id}", params: { post: put_params }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["content"]).to eq("Updated test post")
    end
  end

  describe "DELETE /posts/:id" do
    it "deletes a post" do
      delete "/posts/#{existing_post.id}"

      expect(response).to have_http_status(:no_content)
      expect(Post.find_by(id: existing_post.id)).to be_nil
    end
  end
end