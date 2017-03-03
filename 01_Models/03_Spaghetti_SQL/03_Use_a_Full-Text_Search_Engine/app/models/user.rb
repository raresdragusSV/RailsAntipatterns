class User < ActiveRecord::Base
  def self.search(terms, page)
    columns = %w(name login location country)
    tokens  = terms.split(/\s+/)

    if tokens.empty?
      conditions = nil
    else
      conditions = tokens.collect do |token|
        columns.collect do |column|
          "#{column} LIKE '%#{connection.quote(token)}%'"
        end
      end
      conditions = conditions.flatten.join(' OR ')
    end

    paginate conditions: conditions, page: page
  end
end

# using Sphinx
class User < ActiveRecord::Base
  define_index do
    indexes name, login, location, country
  end
end

# advanced functionality
class User < ActiveRecord::Base
  define_index do
    indexes name, login, location, country
    has deleted, created_at
  end
end

# using delta_indexes
class User < ActiveRecord::Base
  define_index do
    indexes name, login, location, country
    set_property delta: true
  end
end
