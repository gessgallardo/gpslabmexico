# frozen_string_literal: true

# GenerateMailer handler class
class GenerateMailer
  attr_accessor :name, :template, :html

  def initialize(name:)
    @name = name
  end

  def create_html
    File.open("#{template_filename}.html.mjml", 'rb') do |f|
      @template = f
      @html = File.open(output_filename, 'wb')
      @html.write(MJML::Parser.new.call(parse_template(f)))
      @html.close
    end
    output_filename
  end

  def parse_template(template)
    converted_file = template.read.gsub('{{mailerName}}', name)
    converted_file = converted_file.gsub('rgba(0,0,0,0.8)', 'transparent')
    converted_file
  end

  def template_filename
    @template_filename ||= [Dir.pwd, '/mailers/mjml/template'].join
  end

  def output_filename
    @output_filename ||= [Dir.pwd, "/mailers/html/#{@name}.html"].join
  end
end
