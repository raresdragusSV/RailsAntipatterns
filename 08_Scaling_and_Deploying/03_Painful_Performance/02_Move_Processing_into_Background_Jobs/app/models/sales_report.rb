class SalesReport < Struct.new(:user)
  def perform
    report = generate_report
    Mailer.sales_report(user, report).deliver
  end

  private

  def generate_report
    FasterCSV.generate do |csv|
      csv << CSV_HEADERS
      Sales.find_each do |sale|
        csv << sale.to_a
      end
    end
  end
end
