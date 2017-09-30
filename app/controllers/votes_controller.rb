post "/questions/:voteable_id/votes" do
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
  voteable.votes << Vote.new(value: params[:vote_val], user_id: 0)
  redirect "/questions/#{params[:voteable_id]}"
end
