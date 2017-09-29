
get '/questions/:question_id/answers' do
  @question = Question.find(params[:question_id])
  erb :'/questions/show'
end

post '/questions/:question_id/answers' do
    answer = Answer.new(params[:answer])
    if answer.valid?
      answer.save
      redirect "/questions/#{params[:question_id]}/answers"
    else
      status 404
      return "error"
    end
end
