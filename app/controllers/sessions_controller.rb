post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect '/questions'
  else
    status 422
    @errors = ["User email, password combination is incorrect."]
    redirect '/questions'
  end
end

delete '/sessions' do
  if session
    session.clear
    redirect '/questions'
  else
    redirect '/questions'
  end
end
