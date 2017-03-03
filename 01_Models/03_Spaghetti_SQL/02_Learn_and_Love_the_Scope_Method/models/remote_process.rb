class RemoteProcess < ActiveRecord::Base
  def self.find_top_running_processes(limit = 5)
    find(
      :all,
      conditions: "state' = 'Running'",
      order: 'percent_cpu desc',
      limit: limit
    )
  end

  def self.find_top_running_system_processes(limit = 5)
    find(
      :all,
      conditions: "state' = 'Running' and (owner in ('root', 'mysql')",
      order: 'percent_cpu desc',
      limit: limit
    )
  end
end

# using scopes
class RemoteProcess < ActiveRecord::Base
  scope :running, where(state: 'Running')
  scope :system,  where(owner: %w(root mysql))
  scope :sorted,  order('percent_cpu desc')
  scope :top,     ->(l) { limit(l) }

  def self.find_top_running_processes(limit = 5)
    running.sorted.top(limit)
  end

  def self.find_top_running_system_processes(limit = 5)
    running.sytem.sorted.top(limit)
  end
end
