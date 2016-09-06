class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :secret, null: false, default: false

      t.timestamps
    end
  end
end
