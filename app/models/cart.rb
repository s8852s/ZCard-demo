class Cart

  def initialize(items = [])
    @items = items
  end
  # 預設的initialize是空的 沒有任何東西

  def add_item(item_id, quantity = 1)
    # @items = []
    found_item = @items.find { |item| item.item_id == item_id }
    if found_item
      found_item.increment
    else
      @items << CartItem.new(item_id, quantity)
    end
  end

  def empty?
    @items.empty?
    # 陣列的empty方法
  end

  def items
    @items
  end

  def total_price
    total = @items.sum { |item| item.total_price }

    if Date.today.month == 12 && Date.today.day == 15
      total = total * 0.9
    end
    total

    # @items.reduce(0) { |sum, item| sum + item.total_price }
    # @items.sum { |item| item.total_price }

    # total = 0
    # @items.each do |item|
    #   total = total + item.total_price
    # end
    # total
  end

  def serialize
    # items = []
    # @items.each do |item|
    #   items << { "item_id" => item.item_id,
    #              "quantity" => item.quantity }
    # end

    items = @items.map { |item| { "item_id" => item.item_id, 
                                  "quantity" => item.quantity } 
                       }

    # [
    #   { "item_id" => 1, "quantity" => 3 },
    #   { "item_id" => 2, "quantity" => 2 }
    # ]

    { "items" => items }
  end

  def self.from_hash(hash)
    if hash && hash['items'] # hash裡要有'items'這個key
      # 還原
      # items = []
      # hash["items"].each do |item|
      #   items << CartItem.new(item["item_id"], item["quantity"])
      # end
      items = hash["items"].map { |item| CartItem.new(item["item_id"],
                                                      item["quantity"]) }
      Cart.new(items)
    else
      Cart.new
    end
  end
end