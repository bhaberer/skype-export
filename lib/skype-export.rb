require 'sqlite3'
require 'sequel'
require 'skype-export/version'
require 'skype-export/config'
require 'skype-export/message'
require 'skype-export/message/format'

# Module for exporting skype history.
module SkypeExport
  def self.database_for_user(username)
    location = SkypeExport::Config.location(username)
    Sequel.sqlite(location)
  end

  def self.history_with_user(username, database)
    raise 'Username cannot be blank.' if username.nil? || username == ''
    database[select_statement(username)]
  end

  def self.write_to_file(dataset, filename)
    File.open(filename, 'w') do |file|
      dataset.each do |message_hash|
        message = SkypeExport::Message.new(message_hash)
        file.puts(message.to_s) unless message.to_s.nil?
      end
    end
  end

  def self.select_statement(user, order = 'timestamp')
    "SELECT * FROM Messages WHERE chatname LIKE '%#{user}%' "\
    "ORDER BY #{order}"
  end
end
