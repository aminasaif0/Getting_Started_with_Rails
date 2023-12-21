class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  enum state: { active: "active", pending: "pending" }
  # default_scope lambda {order("updated_at desc")}
end
