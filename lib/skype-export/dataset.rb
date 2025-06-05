require 'sqlite3'
require 'sequel'

# Class for formatting and managing the raw data retrieved from the Skype
#   main.db sqlite database.
class Dataset
  def self.database_for_user(username:)
    Sequel.sqlite(SkypeExport::Config.location(skype_username: username))
  end

  def self.first_message_date_with_user(username:, database:)
    history = history_with_user(username:, database:)

    raise ArgumentError, 'No history forund with that user' if history.empty?

    Time.at(history.first[:timestamp])
  end

  def self.history_with_user(username:, database:)
    query_str = query(username:)

    puts query_str

    database[query_str]
  end

  def self.history_with_user_for_month(username, year, month, database)
    date_start = Time.new(year, month, 1).to_i
    date_end = Time.new(year, month, Date.new(year, month, -1).day).to_i
    database[query(username:, start_time: date_start, end_time: date_end)]
  end

  def self.history_with_user_for_year(username, year, database)
    date_start = Time.new(year, 1, 1).to_i
    date_end = Time.new(year, 12, 31).to_i
    database[query(username:, start_time: date_start, end_time: date_end)]
  end

  def self.query(username:, order: 'timestamp', start_time: nil, end_time: nil)
    sql = ["SELECT * FROM Messages WHERE chatname LIKE '%#{username}%'"]

    sql << "AND timestamp BETWEEN \"#{start_time}\" AND \"#{end_time}\"" if start_time && end_time

    sql << "ORDER BY #{order}"

    sql.join(' ')
  end
end
