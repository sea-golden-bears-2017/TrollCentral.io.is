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
    question_id = voteable.id
  when "answer"
    voteable = Answer.find_by_id(params[:voteable_id])
    question_id = voteable.question.id
  else
    status 404
    return "Error - 404"
  end
  if !voteable.votes.pluck(:user_id).include?(user.id)
    Vote.create(value: params[:vote_val], user: user, voteable: voteable)
  end
  redirect "/questions/#{question_id}"
end
