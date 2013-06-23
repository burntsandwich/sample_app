class QueryGenerator < ActiveRecord::Base
  belongs_to :term
  belongs_to :search

  validates :search_id, presence: true
  validates :term_id, presence: true 
end
