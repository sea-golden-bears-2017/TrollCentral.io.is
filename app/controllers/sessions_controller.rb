put '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user != nil
    session[:user_id] = user.id
    redirect :'/questions'
  end
    status 422
    @errors = ["User email, password combination is incorrect."]
    @questions = Question.all
    erb :'/questions/index'
end

delete '/sessions' do
  if session[:user_id]
    session.destroy
    redirect '/questions'
  else
    status 404
  end
end
