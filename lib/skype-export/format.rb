module SkypeExport
  module Format
    def self.message(message)
      text = body(message[:body_xml])
      time = time(message[:timestamp])
      from = message[:from_dispname]
      if message[:type] == 60
        action_message(time, from, text)
      else
        chat_message(time, from, text)
      end
    end

    def self.action_message(time, from, text)
      "[#{time}] * #{from} #{text} *"
    end

    def self.chat_message(time, from, text)
      "[#{time}] <#{from}> #{text}"
    end

    def self.body(body_text)
      return if body_text.nil?
      [[/&apos;/, "'"], [/&quot;/, '"'],
       [/&lt;/, '<'], [/&gt;/, '>'], [/&amp;/, '&'],
       [/<\/pre>/, '{code}'], [/<pre raw_pre="(!!\s|\{code\})".*>/, '{code}'],
       [/<b raw_pre="\*" raw_post="\*">/, '*'], [/<\/b>/, '*'],
       [/<ss\stype=\".+\">/, ''], [/<\/ss>/, '']].each do |regex, replacement|
        body_text = body_text.gsub(regex, replacement)
      end
      body_text
    end

    def self.time(time)
      Time.at(time).strftime('%Y.%m.%d %H:%M:%S')
    end
  end
end
