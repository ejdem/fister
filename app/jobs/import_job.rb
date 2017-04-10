require 'csv'

class ImportJob < ApplicationJob
  def perform(file)
    CSV.foreach(file,headers: true, encoding: 'ISO-8859-1', col_sep: ';') do |row|
      hash = row.to_hash
      create_epci(hash)
      create_commune(hash)
    end
  end
  
  # Creates Intercommunality record.
  def create_epci(hash)
    Intercommunality.create(detect_epci(hash)) unless Intercommunality.find_by(siren: hash["siren_epci"])
  end
  
  def create_commune(hash)
    Commune.create(detect_commune(hash)) unless Commune.find_by(code_insee: hash["insee"])
  end
  
  def detect_commune(hash)
    Hash.new.tap do |commune|
      commune[:name]  = hash["nom_com"]
      commune[:code_insee] = hash["insee"]
      commune[:population] = hash["pop_total"]
      commune[:intercommunality]  = Intercommunality.find_by(siren: hash["siren_epci"])
    end
  end
  
  def detect_epci(hash)
    Hash.new.tap do |intercom|
      intercom[:name]  = hash["nom_complet"]
      intercom[:siren] = hash["siren_epci"]
      intercom[:form]  = detect_epci_form(hash["form_epci"])
    end
  end
  
  def detect_epci_form(form_epci)
    return 'met' if form_epci.downcase == 'metro'
    form_epci.downcase
  end
end