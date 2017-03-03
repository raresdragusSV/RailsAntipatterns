class Version < ActiveRecord::Base
  before_validation :set_version_number, on: :create
  validates :version, presence: true

  private

  def set_version_number
    self.version =
      (article.current_version ? article.current_version : 0) + 1
  end
end

# adding before_create callback function

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current
  validates :version, presence: true

  private

  def set_version_number
    self.version =
      (article.current_version ? article.current_version : 0) + 1
  end

  def mark_related_links_not_current
    unless article.versions.empty?
      if article.current_version.relateds.any?
        article.current_version.relateds.each do |rel|
          rel.update_attributes(:current, false)
        end
      end
    end
  end
end

# article.current_version.relateds.any? is unnecessary because the loop below
# it will just be skipped if there are no elements.
# Active Record relationship collections on models never return nil
# if there are no records found. Instead, they return an empty collection

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current

  private

  def set_version_number
    self.version =
      (article.current_version ? article.current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    unless article.versions.empty?
      article.current_version.relateds.each do |rel|
        rel.update_attribute(:current, false)
      end
    end
  end
end

# changing the article.versions.empty? condition

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current

  private

  def set_version_number
    self.version =
      (article.current_version ? article.current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    if article.current_version
      article.current_version.relateds.each do |rel|
        rel.update_attribute(:current, false)
      end
    end
  end
end

# create current_version method

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current

  private

  def current_version
    article.current_version
  end

  def set_version_number
    self.version =
      (current_version ? current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    if current_version
      current_version.relateds.each do |rel|
        rel.update_attribute(:current, false)
      end
    end
  end
end

# moving current_version condition in callback function definition

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current,
                if: :current_version

  private

  def current_version
    article.current_version
  end

  def set_version_number
    self.version =
      (current_version ? current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    current_version.relateds.each do |rel|
      rel.update_attribute(:current, false)
    end
  end
end

# create an after_create callback function

class Version < ActiveRecord::Base
  before_validation_on_create :set_version_number
  before_create :mark_related_links_not_current,
                if: :current_version
  after_create :set_current_version_on_article

  private

  def current_version
    article.current_version
  end

  def set_version_number
    self.version =
      (current_version ? current_version.version : 0) + 1
  end

  def mark_related_links_not_current
    current_version.relateds.each do |rel|
      rel.update_attribute(:current, false)
    end
  end

  def set_current_version_on_article
    article.update_attribute(:current_version_id, id)
  end
end
