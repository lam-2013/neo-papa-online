class ChangeNameColumnIdAgeGroupToQuestions < ActiveRecord::Migration
  def up
    rename_column :questions, :id_age_group, :age_group_id
  end

  def down
  end
end
