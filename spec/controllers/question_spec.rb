require 'spec_helper'

describe "Questions Controller" do
  it "it shows an erb GET /questions" do
    get '/questions'
    expect(last_response.status).to eq(200)
  end
  it "it reroutes to landing page POST /questions" do
    post '/questions', {question_text: "Nothing"}
    expect(last_response.location).to end_with("/questions")
  end
  it "it creates a new question on form submit" do
    expect{post '/questions', {question_text: "Nothing"}}.to change{Question.count}.by(1)
  end
end
