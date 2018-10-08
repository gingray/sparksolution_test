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
    buffer = []
    CSV.foreach(csv_file, headers: true) do |row|
      hash = row.to_hash
      if buffer >= ROW_PER_TASK
        ImportProductTask.perform_async buffer
        buffer =[]
      end
      buffer << hash
    end
  end
end