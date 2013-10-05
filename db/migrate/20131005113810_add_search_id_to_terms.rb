class AddSearchIdToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :search_id, :integer
  end
end
