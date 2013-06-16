class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :keyword
      t.float :weight

      t.timestamps
    end
  end
end
