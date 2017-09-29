
get '/questions/1/answers' do

 erb :'/answers/answers'
end

post '/questions/question_id/answers' do

redirect '/questions/question_id/answers'
end
