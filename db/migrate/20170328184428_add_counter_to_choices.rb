class AddCounterToChoices < ActiveRecord::Migration[5.0]
  def change
    add_column :choices, :counter, :integer
  end
end
