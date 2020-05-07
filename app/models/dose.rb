class Dose < ApplicationRecord
  belongs_to :cocktails
  belongs_to :ingredients
end
