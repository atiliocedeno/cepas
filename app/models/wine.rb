class Wine < ApplicationRecord
    has_many :evaluations, dependent: :delete_all
    has_many :wine_cepas, dependent: :delete_all
    validates :name, presence: true
end
