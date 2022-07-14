class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :name
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
