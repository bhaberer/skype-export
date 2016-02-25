module SkypeExport
  module Config
    # Copied from the runoff gem
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

    private

    # Copied from the runoff gem
    def self.get_default_skype_data_location_on_windows_8(skype_username)
      location = "#{ENV['HOME']}/AppData/Local/Packages"
      skype_folder = Dir["#{location}/Microsoft.SkypeApp*"].first

      raise IOError.new "The default Skype directory doesn't exist." unless skype_folder

      "#{skype_folder}/LocalState/#{skype_username}/main.db"
    end
  end
end
