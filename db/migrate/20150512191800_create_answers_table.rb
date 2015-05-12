class CreateAnswersTable < ActiveRecord::Migration
  def change
    create_table(:answers) do |a|
      a.column(:description, :string)
      a.column(:question_id, :int)
      a.column(:counter, :int)

      a.timestamps()
    end
  end
end
