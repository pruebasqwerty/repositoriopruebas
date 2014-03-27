require 'data_mapper'
require 'dm-paperclip'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/config_converter.db")

# encoding: utf-8

class Resource
  include DataMapper::Resource
  include Paperclip::Resource

  property :id,			Serial
  belongs_to :project
  
  has_attached_file :file,
                    :url => "/uploads/:basename-:id.:extension",
                    :path => "#{Dir.pwd}/public/uploads/:basename-:id.:extension"
end

# Table storing the projects
class Project
  include DataMapper::Resource
  
  property :id,     		Serial
  property :name,			String,	:length => 64,	:required => true
  property :description,	String, :length => 255
  
  has n, :resources
  
end

DataMapper.auto_migrate!
DataMapper.finalize.auto_upgrade!