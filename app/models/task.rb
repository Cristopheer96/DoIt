class Task < ApplicationRecord
  validates :title, presence: true
  validates :importance, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :tags, uniqueness: true
  # has_many :tags, :length => { :maximum => 3 }
  belongs_to :user


end
