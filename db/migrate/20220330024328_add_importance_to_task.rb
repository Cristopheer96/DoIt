class AddImportanceToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :importance, :integer
  end
end
