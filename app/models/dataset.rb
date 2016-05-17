class Dataset < ActiveRecord::Base
  belongs_to :catalog

  has_many :distributions, dependent: :destroy

  has_one :dataset_sector, dependent: :destroy
  has_one :sector, through: :dataset_sector

  accepts_nested_attributes_for :dataset_sector
  accepts_nested_attributes_for :distributions, allow_destroy: true

  validate :duplicated_titles

  with_options on: :inventory do |dataset|
    dataset.validates :title, :contact_position, :public_access, :publish_date, presence: true
  end

  with_options on: :catalog do |dataset|
    dataset.validates :description, :accrual_periodicity, :public_access, :publish_date, presence: true
  end

  def identifier
    title.to_slug.normalize.to_s
  end

  def publisher
    catalog.organization.title
  end

  def keywords
    "#{keyword},#{gov_type},#{sectors}".chomp(',').lchomp(',').downcase.strip
  end

  private

  def duplicated_titles
    errors.add(:title, :taken, title: title) if catalog.datasets.map(&:title).include?(title)
  end

  def sectors
    catalog.organization.sectors.map(&:slug).join(',')
  end

  def gov_type
    catalog.organization.gov_type
  end
end
