class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name, presence: true
  validates :siren, presence: true, uniqueness: true
  
end
