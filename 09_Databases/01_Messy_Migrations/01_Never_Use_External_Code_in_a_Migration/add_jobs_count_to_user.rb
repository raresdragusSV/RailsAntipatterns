class AddJobCounttoUser < ActiveRecord::Migration
  def up
    add_column :users, :jobs_count, :integer, default: 0

    Users.all.each do |user|
      user.jobs_count = user.jobs.size
      user.save
    end
  end

  def down
    remove_column :users, :jobs_count
  end
end

# refactoring

class AddJobsCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :jobs_count, :integer, default: 0
    update(<<-SQL)
      UPDATE users SET jobs_count = (
        SELECT count(*) FROM jobs
        WHERE jobs.user_id = users.id
      )
    SQL
  end

  def down
    remove_column :users, :jobs_count
  end
end
