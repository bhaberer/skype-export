# frozen_string_literal: true

require 'skype-export/version'
require 'skype-export/config'
require 'skype-export/message'
require 'skype-export/dataset'
require 'skype-export/message/format'

# Module for exporting skype history.
module SkypeExport
  def self.write_to_file(dataset:, filename:)
    File.open(filename, 'w') do |file|
      dataset.each do |message_hash|
        message = SkypeExport::Message.new(message_hash)
        file.puts(message.to_s) unless message.to_s.nil?
      end
    end
  end
end
