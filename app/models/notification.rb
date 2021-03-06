class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :post

  validates :user_id, :notified_by_id, :post_id, :identifier, :notice_type, presence: true

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
end
