module ImportProductEx
  class ShippingCategory < Base
    def initialize
      super('Need to create at least one shipping category to perform import')
    end
  end
end
