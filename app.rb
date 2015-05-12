require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/survey"
require "./lib/question"

get('/') do

  erb(:index)
end

get '/surveys' do
  @surveys =  Survey.all()
  erb(:surveys)
end

get '/questions' do
  @questions = Question.all()
  erb(:questions)
end

post '/add_survey' do
  name = params.fetch("add_survey")
  Survey.create({name: name})
  redirect('/surveys')
end

post '/add_question' do
  Question.create({question: params.fetch("add_question")})
  redirect('/questions')
end

post '/question/add_new' do
  id = params.fetch("survey_id").to_i
  question = params.fetch("question")
  Question.create({question: question, survey_id: id})
  @survey = Survey.find(id)
  @questions= @survey.questions
  @all_questions = Question.all
  erb(:survey)
end


get '/question/:id' do
  question_id = params.fetch("id")
  @question = Question.find(question_id)
  @all_surveys = Survey.all()
  @surveys = @question.survey
  erb(:question)
end

post '/question/:id/add' do
  survey_id = params.fetch("id")
  question_id = params.fetch("question")
  @question = Question.find(question_id)
  @question.update({survey_id: survey_id})
  @survey = Survey.find(id)
  @questions= @survey.questions
  @all_questions = Question.all
  erb(:question)
end

post '/survey/:id/add' do
  survey_id = params.fetch("id").to_i
  question_id = params.fetch("question").to_i
  @question = Question.find(question_id)
  @question.update({survey_id: survey_id})
  @questions = Question.all
  @surveys = @question.survey
  @survey = Survey.find(survey_id)

  erb(:survey)
end

get '/survey/:id' do
  id = params.fetch("id").to_i
  @survey = Survey.find(id)
  @questions= @survey.questions
  @all_questions = Question.all
  erb(:survey)
end

delete '/survey/:id/delete' do
  id = params.fetch("id").to_i
  @survey = Survey.find(id)
  @survey.delete
  redirect('/surveys')
end

delete '/question/:id/delete' do
  id = params.fetch("id").to_i
  @question = Question.find(id)
  @question.delete
  redirect('/questions')
end

patch '/question/:id/update' do
  id = params.fetch("id")
  @question = Question.find(id)
  question = params.fetch("question")
  @question.update({question: question})
  @all_surveys = Survey.all
  @surveys = @question.survey
  erb(:question)
end

patch '/survey/:id/update' do
  id = params.fetch("id")
  @survey = Survey.find(id)
  name = params.fetch("name")
  @survey.update({name: name})
  @questions= @survey.questions
  @all_questions = Question.all

  erb(:survey)
end
