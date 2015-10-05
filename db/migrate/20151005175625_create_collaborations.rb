class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :collaborator, index: true, foreign_key: true
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
