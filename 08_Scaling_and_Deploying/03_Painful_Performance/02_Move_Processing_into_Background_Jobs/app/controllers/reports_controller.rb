class ReportsController < ApplicationController
  def create
    Delayed::Job.enqueue(
      SalesReport.new(current_user)
    )
  end
end

# using send_later method

class ReportsController < ApplicationController
  def create
    Sale.send_later(:generate_report, current_user)
  end
end
