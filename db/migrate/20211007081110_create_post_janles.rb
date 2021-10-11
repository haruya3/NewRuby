class CreatePostJanles < ActiveRecord::Migration[6.1]
  def change
    create_table :post_janles do |t|
      t.references :post, null: false, foreign_key:  {on_delete: :cascade, on_update: :cascade}
      t.references :janle, null: false, foreign_key: {on_delete: :cascade, on_update: :cascade}

      t.timestamps
    end
  end
end
