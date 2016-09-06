class CreateInquiryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :inquiry_items do |t|
      t.references :inquiry, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
