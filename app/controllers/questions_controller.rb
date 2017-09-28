get '/questions' do
  @questions = Question.all
  erb :index
end

post '/questions' do
  Question.create(question_text: params[:question_text], user_id: 0)
  redirect '/questions'
end
