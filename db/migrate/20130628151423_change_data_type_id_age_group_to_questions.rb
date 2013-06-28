class ChangeDataTypeIdAgeGroupToQuestions < ActiveRecord::Migration
  def up
    change_table :questions do |t|
      t.change :id_age_group, :integer
    end
  end

  def down
    change_table :questions do |t|
      t.change :id_age_group, :string
    end
  end
end
