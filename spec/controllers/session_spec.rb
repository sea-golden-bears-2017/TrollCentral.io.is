require 'spec_helper'

describe 'Session Controller' do
  let!(:user) {User.create!(user_name: "TestName", email: "test@test.com", password: "password")}

  describe "post /sessions" do
    context "when credentials are correct" do
      it "returns 302" do
        post "/sessions", {email: user.email, password: "password"}
        expect(last_response.status).to eq(302)
      end
    end
    context "when credentials are incorrect" do
      it "returns 422" do
        post "/sessions", {email: "Wenis", password: "Hambone"}
        expect(last_response.status).to eq(422)
      end
    end
  end

  describe "delete /sessions" do
    context "when user does not exist" do
      it "returns 404" do
        delete "/sessions"
        expect(last_response.status).to eq(404)
      end
    end
    context "when user_id does exist" do
      it "returns 302" do
        delete "/sessions", {}, "rack.session" => {user_id: user.id}
        expect(last_response.status).to eq(302)
      end
    end
  end
end
