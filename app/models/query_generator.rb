# == Schema Information
#
# Table name: query_generators
#
#  id         :integer         not null, primary key
#  search_id  :integer
#  term_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class QueryGenerator < ActiveRecord::Base
  belongs_to :term
  belongs_to :search

  validates :search_id, presence: true
  validates :term_id, presence: true 
end
