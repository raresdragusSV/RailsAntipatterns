class Song < ActiveRecord::Base
  def self.search(title, artist, genre, published, order, limit, page)
    condition_values = {
      title:  "%#{title}%",
      artist: "%#{artist}%",
      genre: "%#{genre}%"
    }
    case order
    when 'name'
      order_clause = 'name DESC'
    when 'length'
      order_clause = 'duration ASC'
    when 'genre'
      order_clause = 'genre DESC'
    else
      order_clause = 'album DESC'
    end

    joins =      []
    conditions = []
    conditions << "(title LIKE ':title')" unless title.blank?
    conditions << "(artist LIKE ':artist')" unless artist.blank?
    conditions << "(genre LIKE ':genre')" unless genre.blank?

    unless published.blank?
      conditions << '(published_on == :true OR published_on IS NOT NULL)'
    end

    find_opts = {
      conditions: [
        conditions.join(' AND '),
        condition_values
      ],
      joins: joins.join(' '),
      limit: limit,
      order: order_clause
    }
    page = 1 if page.blank?
    paginate(:all, find_opts.merge(page: page, per_page: 25))
  end
end

# reafctoring
class Song < ActiveRecord::Base
  def self.top(number)
    limit(number)
  end

  def self.matching(column, value)
    where(["#{column} like ?", "%#{value}%"])
  end

  def published
    where('published_on is not null')
  end

  def self.order(col)
    sql = case col
          when 'name'
            'name DESC'
          when 'length'
            'duration ASC'
          when 'genre'
            'genre DESC'
          else
            'album DESC'
          end
    order(sql)
  end

  def self.search(title, artist, genre, published)
    finder = matching(:title, title)
    finder = finder.matching(:artist, artist)
    finder = finder.matching(:genre, genre)
    finder = finder.published unless published.blank?
    finder
  end
end

# Song.search("fool", "billy", "rock", true).
#      order("length").
#      top(10).
#      paginate(:page => 1)
