# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_blogs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Blog < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  default_scope { order(created_at: :desc) }
end
