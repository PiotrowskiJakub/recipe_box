class Recipe < ActiveRecord::Base
  belongs_to :user

  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  validates :title, :description, :image, presence: true

  has_attached_file :image,
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename",
    styles: { medium: "400x400#" },
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
