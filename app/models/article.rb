class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  def self.public_count(state = 'all')
    if state == 'all'
      all.count
    elsif %w[active pending].include?(state)
      where(state: state).count
    else
      0
    end
  end
end
