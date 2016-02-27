module SkypeExport
  class Message
    module Format
      TIME_FORMAT = '%Y.%m.%d %H:%M:%S'.freeze

      def self.unescape_html_entities(body_text)
        [%w(apos '), %w(quot "), %w(lt <),
         %w(gt >), %w(amp &)].each do |entity, replacement|
           body_text = body_text.gsub(/&#{entity};/, replacement)
        end
        body_text
      end

      def self.remove_monospaced_markup(body_text)
        body_text.gsub(/<\/pre>|(<pre raw_pre="(!!\s|\{code\})".*>)/, '{code}')
      end

      def self.remote_emoticons(body_text)
        body_text.gsub(/(<ss\stype=\".+\">|<\/ss>)/, '')
      end

      def self.remove_formatting_markup(body_text)
        rx = /(?:<[ibs] raw_pre="(.)" raw_post="(?:.)">)+([^<>]+)(?:<\/[ibs]>)+/
        body_text.gsub(rx,'\1\2\1')
      end

      def self.formatted_time(time)
        "[#{time.strftime(TIME_FORMAT)}]"
      end

      def self.action_message(message)
        "#{formatted_time(message.time)} * #{message.from_name} #{message.text} *"
      end

      def self.chat_message(message)
        "#{formatted_time(message.time)} <#{message.from_name}> #{message.text}"
      end
    end
  end
end
