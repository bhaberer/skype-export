# frozen_string_literal: true

module SkypeExport
  # Class for formatting and managing the raw data retrieved from the Skype
  #   main.db sqlite database.
  class Message
    attr_accessor :text, :from_name, :time, :type

    MESSAGE_TYPES = {
      '10' => :conf_user_add,
      '13' => :conf_user_leave,
      '30' => :call_start,
      '39' => :call_start,
      '51' => :contact_add,
      '60' => :action_message,
      '61' => :chat_message,
      '68' => :file_transfer,
      '70' => :video_share,
      '106' => :contact_birthday,
      '201' => :inline_image,
      '253' => :inline_video,
      '255' => :video_message
    }.freeze

    def initialize(message_hash)
      # Ensure the hash is sane
      consistancy_check(message_hash)

      @type = MESSAGE_TYPES[message_hash[:type].to_s]
      self.text = message_hash[:body_xml]
      self.time = message_hash[:timestamp]
      @from_name = message_hash[:from_dispname]
    end

    def to_s
      case @type
      when :action_message
        Format.action_message(self)
      when :chat_message
        Format.chat_message(self)
      end
    end

    def time=(time)
      time = Time.at(time) if time.is_a?(Integer)
      @time = time
    end

    def text=(body_text)
      return if body_text.nil?

      body_text = Format.unescape_html_entities(body_text)
      body_text = Format.remove_monospaced_markup(body_text)
      body_text = Format.remove_emoticons(body_text)
      body_text = Format.remove_formatting_markup(body_text)
      body_text = Format.remove_anchor_tags(body_text)
      body_text = Format.remove_quote_markup(body_text)
      @text = body_text
    end

    private

    def consistancy_check(hash)
      %i[type timestamp from_dispname].each do |field|
        raise ArgumentError, "#{field} missing from message_hash; #{hash}" unless hash.key?(field) && !hash[field].nil?
      end
    end
  end
end
