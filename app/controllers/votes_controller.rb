post "/questions/:voteable_id/votes" do
  user_id = session[:user_id]
  if !user_id
    status 404
    return "Error - 404"
  end
  user = User.find_by_id(user_id)
  type = params[:type]
  voteable = nil
  case type
  when "question"
    voteable = Question.find_by_id(params[:voteable_id])
  when "answer"
    # FIXME: Change user_id when we add sessions!!!!
    voteable = Answer.find_by_id(params[:voteable_id])
  else
    status 404
    return "Error - 404"
  end
  Vote.create(value: params[:vote_val], user: user, voteable: voteable)
  redirect "/questions/#{params[:voteable_id]}"
end
