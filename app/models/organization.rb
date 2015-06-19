class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title

  has_many :inventories
  has_many :users
  has_many :activity_logs
  has_many :opening_plans, dependent: :destroy

  scope :with_catalog, -> { joins(:inventories).where("inventories.published = 't'").uniq }
  scope :title_sorted, -> { order("organizations.title ASC") }

  def current_inventory
    inventories.unpublished.first
  end

  def current_catalog
    inventories.published.first
  end

  def last_file_version
    inventories.date_sorted.first
  end

  def last_inventory_is_unpublished?
    current_catalog && last_file_version && (current_catalog.id != last_file_version.id)
  end

  def first_published_catalog
    inventories.published.last
  end

  def last_activity_at
    activity_logs.date_sorted.first.done_at if activity_logs.any?
  end

  def current_datasets_count
    if current_inventory.present?
      current_inventory.datasets_count
    else
      0
    end
  end

  def self.search_by(q)
    if q.present?
      where("organizations.title ~* ?", q)
    else
      self.all
    end
  end
end
