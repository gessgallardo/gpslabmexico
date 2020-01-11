# frozen_string_literal: true

# Uploader
class Uploader
  FILES = %w[news capsule promo taller treatment].freeze

  def initialize(name:)
    @name = name
  end

  def upload_files
    file_routes.map { |f| upload(f) }
  end

  def upload(file_route)
    resource = Aws::S3::Resource.new
    file = File.open(file_route)
    filename = File.basename(file_route)
    obj = resource.bucket('gpslabmexico').object("mailers/#{@name}/#{filename}")
    obj.upload_file(file)
    obj.acl.put(acl: 'public-read')
  end

  def file_routes
    @file_routes ||= FILES.map do |f|
      [Dir.pwd, 'public', 'mail', @name, "#{f}.jpg"].join('/')
    end
  end
end
