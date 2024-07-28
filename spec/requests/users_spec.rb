require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "creates a new user" do
      user_params = { user: { username: "testuser", email: "test@example.com", first_name: "Test", last_name: "User" } }
      post "/users", params: user_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["username"]).to eq("testuser")
    end
  end
end
