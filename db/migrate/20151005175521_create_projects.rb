class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :github_url
      t.string :heroku_url

      t.timestamps null: false
    end
  end
end
