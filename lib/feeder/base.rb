$:.unshift(File.dirname(__FILE__))

require 'feedzirra'
require 'base64'
require 'mail'
require 'utils/mailer'
require 'utils/parser'


module Feeder
  
  
  class Worker
        
    @queue = :master
    
    def self.perform(*args)
        parser = Parser.new
        parser.perform
        parser.async
    end
    
  end
  
end