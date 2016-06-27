class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.text :title
      t.text :text

      t.timestamps null: false
    end
  end
end
