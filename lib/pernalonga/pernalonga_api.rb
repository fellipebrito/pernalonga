=begin
require 'bunny'
require 'yaml'
require 'dotenv'
Dotenv.load

module Pernalonga
  class PernalongaApi
    def initialize
      @channel = Bunny.new(connection_parameters).start.create_channel
    end

    def consume(klass, queue)
      @klass = klass

      @channel.queue(queue)
        .subscribe(consumer_tag: 'pernalonga',
                   block: true,
                   manual_ack: true) do |delivery_info, _metadata, msg = q.pop|
        klass.process_message msg
        @channel.acknowledge(delivery_info.delivery_tag, false)
      end

      @channel.close
    end

    def enqueue(queue, message)
      queue = @channel.queue(queue)

      queue.publish(message)

      @channel.close
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

   # def create_channel
   #   @connection.create_channel
   # end
  end
end
=end