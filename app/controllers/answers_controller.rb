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
