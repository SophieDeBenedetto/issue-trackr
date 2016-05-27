class AddNameToRepos < ActiveRecord::Migration
  def change
    add_column :repositories, :name, :string
  end
end
