class Commune < ApplicationRecord
  belongs_to :intercommunality, required: false
  has_many   :street_communes
  has_many :streets, through: :street_communes
  
  validates :name, presence: true, length: { minimum: 1 }
  validates :code_insee, presence: true, length: { is: 5 }
  
  def self.search(word)
    self.name_like(word)
  end

  def self.to_hash
    Hash[all.pluck(:code_insee, :name)]
  end
  
  private
  
  def self.name_like(word)
    return [] if word.include?('%') || word.include?('*')
    where(arel_table[:name].matches("%#{decode_name(word)}%"))
  end
  
  def self.decode_name(word)
    UnicodeUtils.downcase(word)
  end
  
  def self.commune_arel
    self.arel_table
  end
end
