class Book < ApplicationRecord
    belongs_to :author
    has_many :loan

    validates :title, presence: true
    validates :copies, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :author_id, presence: true, numericality: { only_integer: true }
end
