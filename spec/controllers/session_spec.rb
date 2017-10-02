require 'spec_helper'

describe 'Session Controller' do
  let!(:user) {User.create!(user_name: "TestName", email: "test@test.com", password: "password")}

  describe "put /sessions" do
    context "when credentials are correct" do
      it "returns 302" do
        put "/sessions", {email: user.email, password: "password"}
        expect(last_response.status).to eq(302)
      end
    end
    context "when credentials are incorrect" do
      it "returns 422" do
        put "/sessions", {email: "Wenis", password: "Hambone"}
        expect(last_response.status).to eq(422)
      end
    end
  end
end
