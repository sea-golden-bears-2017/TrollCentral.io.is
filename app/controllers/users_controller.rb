get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user])
  user.password = params[:user][:password_hash]
  if user.save
    @message = "Welcome to the Family, Troll!"
    session[:user_id] = user.id
    redirect '/questions'
  else
    status 422
    @errors = user.errors.full_messages
    redirect '/users/new'
  end
end
