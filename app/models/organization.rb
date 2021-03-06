class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  validates_presence_of :title

  has_one :administrator
  has_one :catalog, -> { order('created_at desc') }
  has_one :liaison

  has_many :users
  has_many :activity_logs
  has_many :opening_plans, dependent: :destroy
  has_many :inventories
  has_many :organization_sectors, dependent: :destroy
  has_many :sectors, through: :organization_sectors

  accepts_nested_attributes_for :administrator
  accepts_nested_attributes_for :liaison
  accepts_nested_attributes_for :opening_plans, allow_destroy: true
  accepts_nested_attributes_for :organization_sectors, allow_destroy: true

  scope :title_sorted, -> { order("organizations.title ASC") }
  scope :sector, -> slug { joins(:sectors).where('sectors.slug = ?', slug) }
  scope :gov_type, -> gov_type { where('gov_type = ?', Organization.gov_types[gov_type]) }

  enum gov_type: [:federal, :state, :municipal, :autonomous]
end
