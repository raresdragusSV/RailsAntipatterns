class State < ActiveRecord::Base
  validates :name, unique: true
end

class User < ActiveRecord::Base
end

class Category < ActiveRecord::Base
  validates :category, unique: true
end

class Article < ActiveRecord::Base
  belongs_to :state
  belongs_to :categories
  belongs_to :user
end

# SELECT * from articles
# LEFT OUTER JOIN states ON articles.state_id=states.id
# LEFT OUTER JOIN categories ON articles.category_id=categories.id
# WHERE articles.category_id = categories.id
# AND states.name = 'published'
# AND categories.name = 'hiking'
# AND articles.user_id = 123

Article.includes([:state, :category])
       .where('states.name' => 'published',
              'categories.name' => 'hiking',
              'articles.user_id' => current_user)

# refactoring

# SELECT * from articles
# WHERE state_id = 150
# AND category_id = 50
# AND user_id = 123

published_state = State.find_by_name('published')
hiking_category = Category.find_by_name('hiking')
Article.where('state_id' => published_state,
              'category_id' => hiking_category,
              'user_id' => current_user)

# The N+1 Problem

# <table>
#   <tr>
#     <th>Title</th>
#     <th>User</th>
#     <th>State</th>
#     <th>Category</th>
#   </tr>
#   <% @articles.each do |article| %>
#     <% content_tag_for :tr, article do %>
#       <td><%= article.title %></td>
#       <td><%= article.user.name %></td>
#       <td><%= article.state.name %></td>
#       <td><%= article.category.name %></td>
#     <% end %>
#   <% end %>
# </table>

Article.includes([:state, :category, :user])

# SELECT * from articles
# LEFT OUTER JOIN states ON articles.state_id = states.id
# LEFT OUTER JOIN categories ON articles.category_id = categories.id
# LEFT OUTER JOIN users ON articles.user_id = users.id

# Learn to Love the Denormalized Dataset

class Article < ActiveRecord::Base
  STATES = %w(draft review published archived).freeze
  CATEGORIES = %w(tips faqs misc hiking).freeze

  validates :state, inclusion: { in: STATES }
  validates :category, inclusion: { in: CATEGORIES }
end

Article.where('state' => 'published', 'category' => 'hiking',
              'user_id' => current_user)

# or

currnt_user.articles.find_all_by_state_and_category('published', 'hiking')
