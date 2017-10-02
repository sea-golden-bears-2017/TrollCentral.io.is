post '/questions/:question_id/answers' do
    answer = Answer.new(params[:answer])
    if answer.valid?
      answer.save
      redirect "/questions/#{params[:question_id]}"
    else
      status 404
      return "error"
    end
end

post '/questions/:question_id/answers/:answer_id/comments' do
  answer = Answer.find(params[:answer_id])
  Comment.create!(commentable_id: params[:answer_id], commentable_type: 'Answer', comment_text: params[:comment_text], user_id: answer.user_id)
  redirect "/questions/#{params[:question_id]}"
end
