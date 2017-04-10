class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name,  presence: true
  validates :form,  inclusion: { in: %w(ca cu cc met) }
  validates_uniqueness_of :siren, case_sensitive: false
  validates :siren, presence: true, length: { is: 9 }
  
  before_save :generate_slug
  
  def communes_hash
    {}.tap do |hash|
      communes.each do |commune|
        hash.store(commune.code_insee, commune.name)
      end
    end
  end

  def population
    communes.all.pluck(:population).map(&:to_i).sum(0)
  end
  
  private
  
  def self.name_like(word)
    where(intercommunality_arel[:name].matches("%#{word}%"))
  end
  
  def self.intercommunality_arel
    self.arel_table
  end

  def generate_slug
    self[:slug] = name.parameterize.downcase.tr(' ','-') if name && self[:slug].nil?
  end
end
