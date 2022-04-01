class CreateLabelleds < ActiveRecord::Migration[6.1]
  def change
    create_table :labelleds do |t|
      t.references :task, null: false, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
