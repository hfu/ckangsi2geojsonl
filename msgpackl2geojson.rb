require 'msgpack'
require 'json'

MessagePack::Unpacker.new(File.open('ckangsi.msgpackl')).each {|feat|
  p feat
}
