class Commune < ApplicationRecord
  belongs_to :intercommunality
  has_many   :street_communes
  has_many :streets, through: :street_communes
  
  validates :name, presence: true, length: { minimum: 1 }
  validates :code_insee, presence: true, length: { is: 5 }
end
