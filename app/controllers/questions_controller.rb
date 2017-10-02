get '/questions' do
  @questions = Question.all
  erb :'/questions/index'
end

post '/questions' do
  if session[:user_id]
    Question.create(question_text: params[:question_text], user_id: session[:user_id])
    redirect '/questions'
  end
  status 404
  return "Error - 404"
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'/questions/show'
end

post '/questions/:question_id/comments' do
  if !session[:user_id]
    status 404
    return "Error - 404"
  end
  question = Question.find(params[:question_id])
  Comment.create!(commentable_id: params[:question_id], commentable_type: 'Question', comment_text: params[:comment_text], user_id: question.user_id)
  redirect "/questions/#{params[:question_id]}"
end
