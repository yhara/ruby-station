class Application
  include DataMapper::Resource

  property :id, Serial
  property :pid, Integer
  property :port, Integer
  property :name, String
  property :version, String
end
DataMapper.auto_upgrade!
