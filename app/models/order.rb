class Order < ApplicationRecord
  has_attached_file :photo, styles: {
  thumb: '100x100#',
  wide_thumb: '190x95#',
  square: '300x300#',
  medium: '970x485#'
  },	:default_url => ActionController::Base.helpers.asset_path('missing.jpg')

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
