# frozen_string_literal: true

require 'spec_helper'

describe SkypeExport::Message do
  describe '#initialize' do
    context 'when creating a new message with a valid hash' do
      let(:message_hash) do
        { body_xml: 'hiya', from_dispname: 'Myself',
          timestamp: 1_419_231_780, type: 61 }
      end
      let(:message) { SkypeExport::Message.new(message_hash) }

      it 'allows a message to be created with a valid message object' do
        expect(message).to be_a(SkypeExport::Message)
      end
    end

    context 'when creating a new message with invalid message hashs' do
      let(:message_hash) do
        { body_xml: 'hiya', from_dispname: 'Myself',
          timestamp: 1_419_231_780, type: 61 }
      end

      %i[body_xml from_dispname timestamp type].each do |key|
        it "requires a #{key}" do
          message_hash.delete(key)
          expect { SkypeExport::Message.new(message_hash) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
