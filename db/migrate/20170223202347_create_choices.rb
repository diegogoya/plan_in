class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.string :name
      t.string :url
      t.boolean :selected
      t.float :price
      t.references :task, index: true
      t.timestamps
    end
  end
end
