require 'data_mapper'
require 'dm-paperclip'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/config_converter.db")

# encoding: utf-8

class Resource
  include DataMapper::Resource
  include Paperclip::Resource

  property :id,     Serial

  has_attached_file :file,
                    :url => "/uploads/:basename-:id.:extension",
                    :path => "#{Dir.pwd}/public/uploads/:basename-:id.:extension"
end

Resource.auto_migrate!
DataMapper.finalize.auto_upgrade!