# == Schema Information
#
# Table name: searches
#
#  id         :integer         not null, primary key
#  query      :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  name       :string(255)
#

class Search < ActiveRecord::Base
  attr_accessible :query, :name
  belongs_to :user
  has_many :query_generators
  has_many :terms, :through => :query_generators

  validates :user_id, presence: true
  validates :query, presence: true
  default_scope order: 'searches.created_at ASC'
end
