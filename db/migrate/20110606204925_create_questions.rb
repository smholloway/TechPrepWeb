class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :front
      t.text :back
      t.text :raw

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
