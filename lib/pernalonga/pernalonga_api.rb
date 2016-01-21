require 'bunny'
require 'yaml'
require 'dotenv'
Dotenv.load

module Pernalonga
  class PernalongaApi
    def consume(klass, queue)
      @klass = klass

      ch = connect_channel
      ch.queue(queue)
        .subscribe(consumer_tag: 'pernalonga',
                   block: true,
                   manual_ack: true) do |delivery_info, _metadata, msg = q.pop|
        process_message msg
        ch.acknowledge(delivery_info.delivery_tag, false)
      end
    end

    def enqueue(queue, message)
      connect_channel.queue(queue).publish(message)
    end

    private

    def connection_parameters
      {
        host: ENV['BUNNY_HOST'],
        vhost: ENV['BUNNY_VHOST'],
        user: ENV['BUNNY_USER'],
        password: ENV['BUNNY_PASSWORD']
      }
    end

    def connect_channel
      Bunny.new(connection_parameters).start.create_channel
    end

    def process_message(message)
      fail 'You must implement a custom process_message method' unless @klass.process_message(message)
    end
  end
end
