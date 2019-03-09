class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description, null: false
      t.boolean :completed, null: false, default: false
      t.timestamps
    end
  end
end
