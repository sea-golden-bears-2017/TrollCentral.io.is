get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

post '/questions' do
  Question.create(question_text: params[:question_text], user_id: 0)
  redirect '/questions'
end

get '/questions/:id' do
  p params
  @question = Question.find(params[:id])
  @answer = Answer.find_by(question_id: params[:id])
  erb :'/questions/show'
end

post '/questions/:question_id/comments' do
  question = Question.find(params[:question_id])
  Comment.create!(commentable_id: params[:question_id], commentable_type: 'Question', comment_text: params[:comment_text], user_id: question.user_id)
  redirect "/questions/#{params[:question_id]}"
end
