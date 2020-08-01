class Oenologist < ApplicationRecord
    has_many :evaluations, dependent: :delete_all
    has_many :oenologist_magazines, dependent: :delete_all
    validates :name, presence: true
    validates :age, presence: true
    validates :nationality, presence: true
end
