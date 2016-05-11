class Inventories::DatasetsSerializer < ActiveModel::Serializer
  has_many :distributions, root: :distribution, serializer: Inventories::DistributionsSerializer
  attributes :identifier, :title, :description, :modified, :contactPoint, :spatial, :issued, :temporal

  def attributes
    data = super
    data[:language] = 'es'
    data[:publisher] = {
      name: object.publisher,
      mbox: object.mbox
    }
    data[:keyword] = object.keywords.split(',').map(&:squish)
    data[:landingPage] = object.landing_page
    data
  end

  def contactPoint
    "http://adela.datos.gob.mx/api/v1/datasets/#{object.id}/contact_point.vcf"
  end
end