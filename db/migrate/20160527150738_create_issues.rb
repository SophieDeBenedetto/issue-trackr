class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :url
      t.references :repository, index: true
      t.string :title
      t.string :content
      t.string :status
      t.string :opened_by
      t.string :closed_by
      t.timestamps null: false
    end
  end
end
