require 'spec_helper'

describe 'Session Controller' do
  let!(:user) {User.create(username: "TestName", email: "test@test.com", password_hash: "password")}

  describe "get /sessions/:user_id" do
   context "when correct user is logged in" do
     it "returns 303" do
       post "/sessions", {}, "rack.session" => {user_id: user.id}
       expect(last_response.status).to eq(303)
     end
   end
   context "when incorrect user is logged in" do
     it "returns 404" do
       get "/sessions/#{user.id}/channels", {}, "rack.session" => {user_id: other_user.id}
       expect(last_response.status).to eq(404)
     end
   end
  end
end
