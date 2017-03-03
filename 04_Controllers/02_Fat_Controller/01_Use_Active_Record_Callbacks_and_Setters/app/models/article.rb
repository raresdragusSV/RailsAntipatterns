class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    return create_first_version!(attributes, user) if versions.empty?

    # mark old related links as not current
    if current_version.relateds.any?
      current_version.relateds.each do |rel|
        rel.update_attributes(:current, false)
      end
    end

    version = versions.build(attributes)
    version.article_id = id
    version.written_at = Time.now
    version.writer_id = user.id
    version.version = current_version.version + 1
    save!
    update_attributes(:current_version_id, version.id)
    version
  end

  private

  def create_first_version!(attributes, user
    )
    version = versions.build(attributes)
    version.written_at = Time.now
    version.writer_id = user.id
    version.state ||= 'Raw'
    version.version = 1
    save!
    update_attributes(:current_version_id, version.id)
    version
  end
end

# after setting default value for state column

class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    return create_first_version!(attributes, user) if versions.empty?

    # mark old related links as not current
    if current_version.relateds.any?
      current_version.relateds.each do |rel|
        rel.update_attributes(:current, false)
      end
    end

    version = versions.build(attributes)
    version.article_id = id
    version.writer_id = user.id
    version.version = current_version.version + 1
    save!
    update_attributes(:current_version_id, version.id)
    version
  end

  private

  def create_first_version!(attributes, user
    )
    version = versions.build(attributes)
    version.writer_id = user.id
    version.version = 1
    save!
    update_attributes(:current_version_id, version.id)
    version
  end
end

# after creating set_version_number callback function on Version modal and
# removing redundant article_id

class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    return create_first_version!(attributes, user) if versions.empty?

    # mark old related links as not current
    if current_version.relateds.any?
      current_version.relateds.each do |rel|
        rel.update_attributes(:current, false)
      end
    end

    version = versions.build(attributes)
    version.writer_id = user.id
    save!
    update_attributes(:current_version_id, version.id)
    version
  end

  private

  def create_first_version!(attributes, user
    )
    version = versions.build(attributes)
    version.writer_id = user.id
    save!
    update_attributes(:current_version_id, version.id)
    version
  end
end

# after removing create_first_version! method

class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    unless versions.empty?
      # mark old related links as not current
      if current_version.relateds.any?
        current_version.relateds.each do |rel|
          rel.update_attributes(:current, false)
        end
      end
    end

    version = versions.build(attributes)
    version.writer_id = user.id
    save!
    update_attributes(:current_version_id, version.id)
    version
  end
end

# after creating callback functions on Version model

class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    version = versions.build(attributes)
    version.writer_id = user.id
    save!
    update_attributes(:current_version_id, version.id)
    version
  end
end

# updating current_version_id on the Version model

class Article < ActiveRecord::Base
  def create_version!(attributes, user)
    version = versions.build(attributes)
    version.writer_id = user.id
    save!
    version
  end
end

# creating version and setting the writer moved in the controller
# removed unnecessary create_version! method
# creating a new_version getter and setter

class Article < ActiveRecord::Base
  accepts_nested_attributes_for :versions

  def new_version=(version_attributes)
    @new_version = versions.build(version_attributes)
  end

  def new_version
    @new_version
  end
end
