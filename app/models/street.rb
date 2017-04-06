class Street < ApplicationRecord
  has_many :street_communes
  has_many :communes, through: :street_communes
  
  validates :title, presence: true
  
end
