class CreateQueryGenerators < ActiveRecord::Migration
  def change
    create_table :query_generators do |t|
      t.integer :search_id
      t.integer :term_id

      t.timestamps
    end
  end
end
