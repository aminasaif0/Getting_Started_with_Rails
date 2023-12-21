class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  delegate :title, to: :article, prefix: true
  FORMAT_COMMENTER = Proc.new { |comment| "#{comment.commenter}" }

  def formatted_commenter
    FORMAT_COMMENTER.call(self)
  end
end
