class Cepa < ApplicationRecord
    has_many :wine_cepa, dependent: :delete_all
    validates :name, presence: true
end
