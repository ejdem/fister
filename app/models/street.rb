class Street < ApplicationRecord
  has_many :street_communes
  has_many :communes, through: :street_communes
  
  validates :title, presence: true
  validates :from, numericality: true, allow_nil: true
  validates :to, numericality: true, allow_nil: true
  validate :to_greater_than_from
  
  def to_greater_than_from
    errors.add(:to, "Can't be lower than 'from'") if to && from &&  to < from
  end
end
