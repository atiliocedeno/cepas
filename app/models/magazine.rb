class Magazine < ApplicationRecord
    has_many :oenologist_magazines, dependent: :delete_all
    validates :name, presence: true
end
