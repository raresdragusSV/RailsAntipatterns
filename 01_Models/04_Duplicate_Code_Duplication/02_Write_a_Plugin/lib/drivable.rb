require 'drivable/active_record_extensions'

class ActiveRecord::Base
  extend Drivable::ActiveRecordExtensions::ClassMethods
end
