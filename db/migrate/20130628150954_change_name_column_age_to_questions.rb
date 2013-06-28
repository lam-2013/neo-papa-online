class ChangeNameColumnAgeToQuestions < ActiveRecord::Migration
  def up
    rename_column :questions, :age, :id_age_group
  end

  def down
  end
end


