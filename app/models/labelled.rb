class Labelled < ApplicationRecord
  belongs_to :task
  belongs_to :tag, optional: true
end
