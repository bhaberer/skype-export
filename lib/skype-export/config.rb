module SkypeExport
  # Primarily configuration informationa bout the location of the skype db.
  #   Copied from the runoff gem originally.
  module Config
    def self.location(skype_username)
      case RbConfig::CONFIG['host_os']
      when /mingw/
        if File.exist?("#{ENV['APPDATA']}\\Skype")
          format_windows_path "#{ENV['APPDATA']}\\Skype\\#{skype_username}\\main.db"
        else
          format_windows_path self.get_default_skype_data_location_on_windows_8(skype_username)
        end
      when /linux/
        "#{ENV['HOME']}/.Skype/#{skype_username}/main.db"
      else
        "#{ENV['HOME']}/Library/Application Support/Skype/#{skype_username}/main.db"
      end
    end

    def self.format_windows_path(path)
      path = path.gsub(/\\/, '/')
      path.gsub(/^[a-zA-Z]:/, '')
    end

    def self.get_default_skype_data_location_on_windows_8(skype_username)
      location = "#{ENV['HOME']}/AppData/Local/Packages"
      skype_folder = Dir["#{location}/Microsoft.SkypeApp*"].first

      raise IOError.new "The default Skype directory doesn't exist." unless skype_folder

      "#{skype_folder}/LocalState/#{skype_username}/main.db"
    end
  end
end
