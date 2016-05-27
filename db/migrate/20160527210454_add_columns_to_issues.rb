class AddColumnsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :opened_on, :datetime
    add_column :issues, :assignee, :string
  end
end
