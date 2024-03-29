#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/application.rb'

opts = Optimist.options do
  opt :name, 'Mailer Name', type: :string, required: true
end

mailer = Mailer.generate(name: opts[:name])
system `open #{mailer.output_filename}`
