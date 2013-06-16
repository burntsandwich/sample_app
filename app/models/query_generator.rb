class QueryGenerator < ActiveRecord::Base
  attr_accessible :search_id, :term_id

  belongs_to :term
  belongs_to :search
end
