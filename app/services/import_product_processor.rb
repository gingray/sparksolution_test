class ImportProductProcessor
  ROW_PER_TASK = 5

  attr_accessor :csv_file

  def initialize csv_file
    @csv_file = csv_file
  end

  def self.call csv_file
    service = new csv_file
    service.call
  end

  def call
    validate!
    buffer = []
    CSV.foreach(csv_file, headers: true, col_sep: ";") do |row|
      hash = row.to_hash
      if buffer.count >= ROW_PER_TASK
        ImportProductsTask.perform_async buffer
        buffer = []
      end
      buffer << hash
    end
    if buffer.count > 0
      ImportProductsTask.perform_async buffer
    end
    [I18n.t('import_products.success'), nil]
  rescue ImportProductEx::ShippingCategory => e
    [nil, e.message]
  end

  def validate!
    raise ImportProductEx::ShippingCategory unless Spree::ShippingCategory.first
  end
end