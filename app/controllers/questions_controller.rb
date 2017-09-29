get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

post '/questions' do
  Question.create(question_text: params[:question_text], user_id: 0)
  redirect '/questions'
end
