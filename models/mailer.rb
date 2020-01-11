# frozen_string_literal: true

# Mailer handler class
class Mailer
  attr_accessor :name, :template, :html

  def initialize(name:)
    @name = name
  end

  def self.generate(name)
    Mailer.new(name).tap do |g|
      g.upload_files
      g.create_html
    end
  end

  def upload_files
    Uploader.new(name: name).upload_files
  end

  def create_html
    @html = File.open(output_filename, 'wb')
    @html.write(html_content)
    @html.close

    output_filename
  end

  def html_content
    file = File.open(template_filename)
    MJML::Parser.new.call(parse_template(file))
  end

  def parse_template(template)
    converted_file = template.read.gsub('{{mailerName}}', name)
    converted_file = converted_file.gsub('rgba(0,0,0,0.8)', 'transparent')
    converted_file
  end

  def template_filename
    @template_filename ||= [Dir.pwd, '/mailers/mjml/template.html.mjml'].join
  end

  def output_filename
    @output_filename ||= [Dir.pwd, "/mailers/html/#{@name}.html"].join
  end
end
