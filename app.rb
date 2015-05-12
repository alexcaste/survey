require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require "pg"
require "pry"
require "./lib/survey"
require "./lib/question"
require "./lib/answer"

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

get '/answers' do
  @answers = Answer.all()
  @questions = Question.all
  erb(:answers)
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

post '/add_answer/' do
  @answers = Answer.all
  @questions = Question.all
  question_id = params.fetch("question_id")
  description = params.fetch("add_answer")
  Answer.create({description: description, question_id: question_id})
  redirect('/answers')
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

post '/add_new_answer/:id' do
  question_id = params.fetch("question_id")
  description = params.fetch("add_answer")
  Answer.create({description: description, question_id: question_id})
  @answers = Answer.all
  @questions = Question.all
  @question = Question.find(question_id)
  @all_surveys = Survey.all()
  @answer = @question.answers
  erb(:question)
end

get '/question/:id' do
  question_id = params.fetch("id")
  @question = Question.find(question_id)
  @all_surveys = Survey.all()
  @surveys = @question.survey
  @answer = @question.answers
  erb(:question)
end

post '/question/:id/add' do
  survey_id = params.fetch("survey")
  question_id = params.fetch("id")
  @question = Question.find(question_id)
  @question.update({survey_id: survey_id})
  @survey = Survey.find(survey_id)
  @questions= @survey.questions
  @answers = Answer.all
  @questions = Question.all
  @all_surveys = Survey.all()
  @answer = @question.answers

  erb(:question)
end

post '/survey/:id/add' do
  survey_id = params.fetch("id").to_i
  question_id = params.fetch("question").to_i
  @question = Question.find(question_id)
  @question.update({survey_id: survey_id})
  @survey = Survey.find(survey_id)
  @questions= @survey.questions
  @all_questions = Question.all

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

get '/answer/:id/delete' do
  id = params.fetch("id").to_i
  @answer = Answer.find(id)
  @answer.delete
  @answers = Answer.all()
  @questions = Question.all
  erb(:answers)
end

get '/question/:id/del' do
  id = params.fetch("id").to_i
  @answer = Answer.find(id)
  @answer.delete
  @answers = Answer.all()
  @questions = Question.all
  erb(:answers)
end

patch '/question/:id/update' do
  id = params.fetch("id")
  @question = Question.find(id)
  question = params.fetch("question")
  @question.update({question: question})
  @all_surveys = Survey.all
  @surveys = @question.survey
  @answers = Answer.all
  @questions = Question.all
  @answer = @question.answers
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
