class Term < ActiveRecord::Base
  attr_accessible :keyword, :weight

  has_many :query_generators
  has_many :searches, :through => :query_generators

  validates :keyword, presence: true, length: {minimum:3}
  validates :weight, presence: true
end
