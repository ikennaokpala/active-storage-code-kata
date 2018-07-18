class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: false do |t|
      t.string :id, primary_key: true, null: false
    end
  end
end
