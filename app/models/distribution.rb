class Distribution
  attr_accessor :title, :description, :downloadURL, :mediaType, :format, :byteSize, :temporal, :spatial, :accrualPeriodicity

  def initialize(attributes = {})
    attributes.each do |name, value|
      if value.present?
        send("#{name}=", value.force_encoding(Encoding::UTF_8))
      end
    end
  end
end
