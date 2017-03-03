class User < ActiveRecod::Base
  has_and_belongs_to_many :roles, uniq: true

  def has_role?(role_in_question)
    self.roles.first(conditions: { name: role_in_question }) ? true : false
  end

  def has_roles?(roles_in_question)
    roles_in_question =
      self.roles.all(conditions: ['name in (?)', roles_in_question])
    roles_in_question.any?
  end

  def can_post?
    self.has_roles?(%w(admin associate_editor research_writer))
  end

  def can_review_posts?
    self.has_roles?(%w(admin editor associate_editor))
  end

  def can_edit_content?
    self.has_roles?(%w(admin editor associate_editor))
  end

  def can_edit_post?(post)
    self == post.user || self.has_roles?(%w(admin editor associate_editor))
  end
end

# using Simplify with Simple Flags
class User < ActiveRecod::Base
  has_many :roles
end

# refactoring
class User < ActiveRecod::Base
  has_many :roles

  Role::TYPES.each do |role_type|
    define_method "#{role_type}?" do
      roles.exists?(name: role_type)
    end
  end
end
