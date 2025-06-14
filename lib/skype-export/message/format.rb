# frozen_string_literal: true

module SkypeExport
  class Message
    # Module to manage the tasks of parsing and formatting message data
    module Format
      TIME_FORMAT = '%Y.%m.%d %H:%M:%S'
      TEXT_MARKUP_REGEX =
        %r{(?:<[ibs] raw_pre="(.)" raw_post="(?:.)">)+([^<>]+)(?:</[ibs]>)+}.freeze

      def self.remove_anchor_tags(body_text)
        body_text.gsub(%r{<a[^>]+>([^<]+)</a>}, '\1')
      end

      def self.unescape_html_entities(body_text)
        [%w[apos '], %w[quot "],
         %w[lt <], %w[gt >], %w[amp &]].each do |entity, replacement|
          body_text = body_text.gsub(/&#{entity};/, replacement)
        end
        body_text
      end

      def self.remove_monospaced_markup(body_text)
        body_text.gsub(%r{(?:<pre raw_pre="\{code\}" raw_post="\{code\}">|<pre raw_pre="!! ">)(.+)</pre>},
                       '{code}\1{code}')
      end

      def self.remove_quote_markup(body_text)
        body_text.gsub(%r{<quote[^>]+><legacyquote>([^<]+)</legacyquote>},
                       '\1')
      end

      def self.remove_emoticons(body_text)
        body_text.gsub(%r{(<ss\stype=".+">|</ss>)}, '')
      end

      def self.remove_formatting_markup(body_text)
        body_text.gsub(TEXT_MARKUP_REGEX, '\1\2\1')
      end

      def self.formatted_time(time)
        "[#{time.strftime(TIME_FORMAT)}]"
      end

      def self.action_message(msg)
        "#{formatted_time(msg.time)} * #{msg.from_name} #{msg.text} *"
      end

      def self.chat_message(msg)
        "#{formatted_time(msg.time)} <#{msg.from_name}> #{msg.text}"
      end
    end
  end
end
