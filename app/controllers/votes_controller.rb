post "/questions/:voteable_id/votes" do
  type = params[:type]
  case type
  when "question"
    question = Question.find_by_id(params[:voteable_id])
    question.votes << Vote.new(vote_val: params[:vote_val], user_id: 0)
  when "answer"
    # FIXME: Change user_id when we add sessions!!!!
    answer = Answer.find_by_id(params[:voteable_id])
    answer << Vote.new(vote_val: params[:vote_val], user_id: 0)
  else
    status 404
  end
end
