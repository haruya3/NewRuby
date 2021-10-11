class CreateJanles < ActiveRecord::Migration[6.1]
  def change
    create_table :janles do |t|
      t.string :janle

      t.timestamps
    end
  end
end
