class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key:  {on_delete: :cascade, on_update: :cascade}
      t.references :post, null: false, foreign_key:  {on_delete: :cascade, on_update: :cascade}

      t.timestamps
    end
  end
end
