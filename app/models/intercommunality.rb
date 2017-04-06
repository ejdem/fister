class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name,  presence: true
  validates :form,  inclusion: { in: %w(ca cu cc met) }
  validates :siren, presence: true, length: { is: 9 }
  validates_uniqueness_of :siren, case_sensitive: false
end
