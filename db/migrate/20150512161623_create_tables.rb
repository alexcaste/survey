class CreateTables < ActiveRecord::Migration
  def change
    create_table(:surveys) do |s|
      s.column(:name, :string)

      s.timestamps()
    end
      create_table(:questions) do |q|
        q.column(:question, :string)
        q.column(:survey_id, :int)

        q.timestamps()
      end
   end
end
