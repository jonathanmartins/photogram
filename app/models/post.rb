class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :image, presence: true
  validates :user_id, presence: true
  validates :caption, length: { minimum: 3, maximum: 300 }

  paginates_per 3

  has_attached_file :image, styles: { :medium => "640x640" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
