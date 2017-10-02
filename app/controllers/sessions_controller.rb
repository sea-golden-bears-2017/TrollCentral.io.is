post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  p user
  if user != nil
    p "new session"
    session[:user_id] = user.id
    p session
    redirect '/questions'
  end
    p "user not found"
    # status 422
    p session
    @errors = ["User email, password combination is incorrect."]
    @questions = Question.all
    erb :'/questions/index'
end

delete '/sessions' do
  if session[:user_id]
    session.destroy
    p session
    redirect '/questions'
  else
    p "not logged in."
    redirect '/questions'
  end
end
