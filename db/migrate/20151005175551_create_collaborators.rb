class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :github_username

      t.timestamps null: false
    end
  end
end
