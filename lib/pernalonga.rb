require 'pernalonga/version'
require 'pernalonga/pernalonga_api.rb'

module Pernalonga
  def self.consume(klass, queue)
    PernalongaApi.new.consume klass, queue
  end

  def self.enqueue(queue, message)
    PernalongaApi.new.enqueue queue, message
  end
end
