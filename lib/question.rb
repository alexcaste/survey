class Question < ActiveRecord::Base
  belongs_to(:survey)
  has_many(:answers)
  validates(:question, :presence => true)
  before_save(:upcase_question)

private
  def upcase_question
    self.question = question.capitalize
  end
end
