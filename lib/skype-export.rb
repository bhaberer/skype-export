require 'sqlite3'
require 'sequel'
require 'skype-export/version'
require 'skype-export/config'
require 'skype-export/format'

module SkypeExport
  def self.database_for_user(username)
    location = SkypeExport::Config.location(username)
    Sequel.sqlite(location)
  end

  def self.history_with_user(username, database)
    fail 'Username cannot be blank.' if username.nil? || username == ''
    database[select_statement(username)]
  end

  def self.write_to_file(dataset, filename)
    File.open(filename, 'w') do |file|
      dataset.each do |row|
        file.puts(SkypeExport::Format.message(row))
      end
    end
  end

  private

  def self.select_statement(user, order = 'timestamp')
    "SELECT * FROM Messages WHERE chatname LIKE '%#{user}%' "\
    "ORDER BY #{order}"
  end
end
