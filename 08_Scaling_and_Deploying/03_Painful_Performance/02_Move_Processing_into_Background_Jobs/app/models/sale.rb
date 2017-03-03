class Sale < ActiveRecord::Base
  def self.generate_report(user)
    report = FasterCSV.generate do |csv|
      csv << CSV_HEADERS
      find_each do |sale|
        csv << sale.to_a
      end
    end
    Mailer.sales_report(user, report).deliver
  end
end
