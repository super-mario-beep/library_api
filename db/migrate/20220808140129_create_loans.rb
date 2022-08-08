class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|

      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
