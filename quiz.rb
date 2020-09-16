# value/number of orders per customer for the sales dept
# each order is represented by a hash within an array
# more than one order per customer

# sales dept wants to report 2 things:
#1 total value of orders per customer
#2 total value of fufilled orders per customer

# micichael richards:
# 205.65 total value of orders
# only has 1 fufilled order
# 120 total value of fufilled orders

# emma lopez:
# 483.48 total value of orders
# has 2 fufilled orders
# 425.48 total value of fufilled orders

#1. convert the data to a more usable format => restructure data
#2. extract the required information from the new restructured data


# customer_orders = [
#   {customer_id: 12, customer_name: 'Emma Lopez', orders: [{ order_fulfilled: true, order_value: 135.99 }, { order_fulfilled: true, order_value: 289.49 }, { order_fulfilled: false, order_value: 58.00 }]  },
#   {customer_id: 32, customer_name: 'Michael Richards', orders: [{ order_fulfilled: true, order_value: 120.00 }, { order_fulfilled: false, order_value: 85.65 }]  },
# ]
#
# customer_orders = {}
#
# order_data.each do |row|
#   if customer_orders.has_key?(row[:customer_id])
#     customer_orders[row[:customer_id]][:orders] << {
#       order_fulfilled: row[:order_fulfilled],
#       order_value: row[:order_value]
#     }
#   else
#     customer_orders[row[:customer_id]] = {
#       customer_id: row[:customer_id],
#       customer_name: row[:customer_name],
#       orders: [
#         {
#           order_fulfilled: row[:order_fulfilled],
#           order_value: row[:order_value]
#         }
#       ]
#     }
#   end
# end
#
# customer_orders = customer_orders.values

customer_orders = [
  {
    customer_id: 12,
    customer_name: 'Emma Lopez',
    orders: [
      { order_fulfilled: true, order_value: 135.99 },
      { order_fulfilled: true, order_value: 289.49 },
      { order_fulfilled: false, order_value: 58.00 }
    ]
  },
  {
    customer_id: 32,
    customer_name: 'Michael Richards',
    orders: [
      { order_fulfilled: true, order_value: 120.00 },
      { order_fulfilled: false, order_value: 85.65 }
    ]
  }
]

# all_orders = customer_orders.map do |customer|
#   {
#     customer_id: customer[:customer_id],
#     customer_name: customer[:customer_name]
#   }
# end
#
# customer_orders.each_with_index do |data, index|
#   order_value = data[:orders].reduce(0) do |total, order|
#     total + order[:order_value]
#   end
#
#   all_orders[index][:total_order_value] = order_value
# end

# all_orders = customer_orders.map do |customer_data|
#   order_value = customer_data[:orders].inject(0) do |total, order_data|
#     total + order_data[:order_value]
#   end
#
#   {
#     customer_id: customer_data[:customer_id],
#     customer_name: customer_data[:customer_name],
#     total_order_value: order_value
#   }
# end

# all_orders = []
# customer_orders.each do |customer_data|
#   customer_total_orders = {
#     customer_id: customer_data[:customer_id],
#     customer_name: customer_data[:customer_name],
#     total_order_value: 0
#   }
#   customer_data[:orders].each do |order|
#     customer_total_orders[:total_order_value] += order[:order_value]
#   end
#   all_orders << customer_total_orders
# end


fulfilled_orders = customer_orders.map do |customer|
  {
    customer_id: customer[:customer_id],
    customer_name: customer[:customer_name]
  }
end

customer_orders.each_with_index do |data, index|
  order_value = data[:orders].reduce(0) do |total, order|
    total + order[:order_value] if order[:order_fulfilled] == true
  end

  fulfilled_orders[index][:order_value] = order_value
end

