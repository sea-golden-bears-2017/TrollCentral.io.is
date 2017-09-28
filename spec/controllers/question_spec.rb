require 'spec_helper'

describe "Questions Controller" do
  it "it shows an erb GET /questions" do
    get '/questions'
    expect(last_response.status).to eq(200)
  end
end
