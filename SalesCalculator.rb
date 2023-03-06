module Calculation
    def calculate_basic(basic_product_price, imported)
        if imported
            basic_product_price += basic_product_price * 0.15
            return basic_product_price.round(2)
        else 
            basic_product_price += basic_product_price * 0.10
            return basic_product_price.round(2)
        end
    end

    def calculate_imported(price)
        price += price * 0.05
        return price.round(2)
    end
end

include Calculation
class Product
    attr_accessor :exempt_products, :basic_products
    def initialize
        @exempt_products = ["book", "box of chocolates", "chocolate bar", "packet of headache pills"]
        @basic_products = ["music CD", "bottle of perfume"]
    end
end

print "Enter number of products: "
number_of_products = gets.chomp.to_i

puts "Enter products: "
product_array = Array.new
it = 0
while it < number_of_products
    product_detail = gets.chomp
    product_array.push(product_detail)
    it += 1
end

total_without_tax = 0
total = 0
product_obj = Product.new
output_receipt =  Array.new

for it in product_array
    string_array = it.split(" ")    
    quantity_var = string_array[0]
    product_price = string_array[-1].to_f
    total_without_tax += product_price
    final_product_name = string_array[0...-2].join(" ")
    product_name = string_array[1...-2]
    imported = false
    imported = true if final_product_name.include? "imported"
    final_product_name += " : "
    str = ""
    product_name.each do |it| 
        str += it + " " if it != "imported"
    end
    calculate_amount = 0
    if product_obj.exempt_products.include? str.strip
        if imported
            calculate_amount = calculate_imported(product_price)
        else 
            calculate_amount = product_price
        end
    elsif product_obj.basic_products.include? str.strip
        calculate_amount = calculate_basic(product_price, imported)
    end
    total += calculate_amount
    final_product_name += calculate_amount.to_s
    output_receipt.push(final_product_name)
end

puts "\n\n****************Receipt****************\n\n"
for it in output_receipt
    puts it
end
sales_tax = (total - total_without_tax).round(2)
total = total.round(2)
puts "Sales Taxes: " + sales_tax.to_s
puts "Total: " + total.to_s