require 'bunny'
require 'yaml'
require 'dotenv'
Dotenv.load

module Pernalonga
  class PernalongaApi
    attr_accessor :connection

    def initialize
      @connection = Bunny.new(connection_parameters).start
    end

    def consume(klass, queue)
      @klass = klass

      ch = create_channel
      ch.queue(queue)
        .subscribe(consumer_tag: 'pernalonga',
                   block: true,
                   manual_ack: true) do |delivery_info, _metadata, msg = q.pop|
        klass.process_message msg
        ch.acknowledge(delivery_info.delivery_tag, false)
      end
    end

    def enqueue(queue, message)
      channel = create_channel
      queue = channel.queue(queue)

      queue.publish(message)
    end

    def close
      @connection.close
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

    def create_channel
      @connection.create_channel
    end
  end
end
