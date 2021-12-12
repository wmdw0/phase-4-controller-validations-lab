class Post < ApplicationRecord
    validates :title, presence: true
    validates :category, inclusion: { in: (["Fiction", "Non-Fiction"]),
    message: "is not included in the list" }
    validates :content, length: { minimum: 100 }
end
