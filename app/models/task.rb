class Task < ActiveRecord::Base
  belongs_to :project

  validates :title,           presence: true
  validates :description,     presence: true
  validates :urgency,         numericality: {
                                    only_integer: true,
                                    greater_than: 0,
                                    less_than_or_equal_to: 5
                                    }
end
