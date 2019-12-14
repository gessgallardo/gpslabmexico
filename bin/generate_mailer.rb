#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/application.rb'

opts = Optimist.options do
  opt :name, 'Mailer Name', type: :string, required: true
end

generator = GenerateMailer.new(name: opts[:name])
generator.create_html

system `open #{generator.output_filename}`
