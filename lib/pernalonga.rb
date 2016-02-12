require 'pernalonga/version'
require 'pernalonga/pernalonga_api.rb'

module Pernalonga
  def self.close
    @pernalonga.close
  end

  def self.consume(klass, queue)
    @pernalonga ||= PernalongaApi.new
    @pernalonga.consume klass, queue
  end

  def self.enqueue(queue, message)
    @pernalonga ||= PernalongaApi.new
    @pernalonga.enqueue queue, message
  end
end
