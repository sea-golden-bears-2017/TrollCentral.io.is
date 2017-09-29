
get '/questions/:question_id/answers' do
  @question = Question.find(params[:question_id])
  erb :'/questions/show'
end

post '/questions/question_id/answers' do

redirect '/questions/question_id/answers'
end
