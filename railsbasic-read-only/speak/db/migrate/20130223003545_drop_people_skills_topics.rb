class DropPeopleSkillsTopics < ActiveRecord::Migration
  def change

    drop_table :people
    drop_table :skills
    drop_table :topics

  end
end
