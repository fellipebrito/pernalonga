require 'spec_helper'

describe Pernalonga do
  it 'has a version number' do
    expect(Pernalonga::VERSION).not_to be nil
  end

  context 'reads the necessary env variables' do
    it 'has a host' do
      expect(ENV['BUNNY_HOST']).to be_truthy
      expect(ENV['BUNNY_VHOST']).to be_truthy
      expect(ENV['BUNNY_USER']).to be_truthy
      expect(ENV['BUNNY_PASSWORD']).to be_truthy
    end
  end

  it 'enqueues a given message' do
    allow(Bunny).to receive_message_chain(:new,
                                          :start,
                                          :create_channel,
                                          :queue,
                                          :publish)

    allow(Bunny).to receive_message_chain(:new, :start, :close).and_return('BunnyObject')

    enqueue = Pernalonga.enqueue('pernalonga', 'queue-name')

    expect(enqueue).to eql 'BunnyObject'
  end

  it 'starts a consumer and call process_message on the given class' do
    # setup
    channel = double
    delivery_info = double
    original_class = double

    allow(Bunny).to receive_message_chain(:new, :start, :close)

    allow(Bunny).to receive_message_chain(:new,
                                          :start,
                                          create_channel: channel)

    allow(channel).to receive_message_chain(:queue,
                                            :subscribe).and_yield(delivery_info,
                                                                  '_metadata',
                                                                  'Zup, Doc?')

    allow(original_class).to receive(:process_message)
    allow(delivery_info).to receive(:delivery_tag)
    allow(channel).to receive(:acknowledge)

    # validate
    expect(original_class).to receive(:process_message).with('Zup, Doc?')

    # perform
    Pernalonga.consume original_class, 'queue-name'
  end
end
