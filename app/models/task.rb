class Task < ApplicationRecord
  validates :title, presence: true , uniqueness: true
  validates :importance, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  has_many :labelleds, dependent: :destroy
  # has_many :tags, :length => { :maximum => 3 }
  belongs_to :user


end
