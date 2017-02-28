class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :event, index: true

      t.timestamps
    end
  end
end
