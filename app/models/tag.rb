class Tag < ApplicationRecord
  has_many :labelleds, dependent: :destroy

  belongs_to :user
  validates :title, presence: true, uniqueness: true
end
