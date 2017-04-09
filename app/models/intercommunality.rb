class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name,  presence: true
  validates :form,  inclusion: { in: %w(ca cu cc met) }
  validates :siren, presence: true, length: { is: 9 }
  validates_uniqueness_of :siren, case_sensitive: false
  
  before_save :generate_slug
  
  def communes_hash
    {}.tap do |hash|
      communes.each do |commune|
        hash.store(commune.code_insee, commune.name)
      end
    end
  end
  
  def generate_slug
    self[:slug] = name.parameterize.downcase.tr(' ','-') if self[:slug].nil?
  end
  
  private
  
  def self.name_like(word)
    where(intercommunality_arel[:name].matches("%#{word}%"))
  end
  
  def self.intercommunality_arel
    self.arel_table
  end
end
