#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/application.rb'

opts = Optimist.options do
  opt :name, 'Mailer Name', type: :string, required: true
end

campaing = Campaing.new(name: opts[:name])
campaing.create

system `open #{campaing.output_filename}`
