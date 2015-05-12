class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:upcase_name)
  validates(:name, :presence => true)


private

  def upcase_name
    self.name = (name.titlecase)
  end
end
