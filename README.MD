##**BRIEF:**  
See "Till tech test" below.

##**APPROACH:**  
This app is built using Ruby.  
Interaction is via IRB.  
Rspec is used for testing the app.

##**NOTES:**
I assumed a discount system where certain items are discounted by a given percentage for a given period. The format of this is as follows:  

| Product            | Discount %   | Start Date    | End Date       |
| ------------------ | :----------: | :-----------: | :------------: |
| Cafe Latte         | 4            | 1/1/2016      | N/A            |
| Americano          | 5            | 15/11/2016    | 31/12/2016     |
| Blueberry Muffin   | 6            | N/A           | 1/6/2017       |

The system checks if a discount is applicable to a product by verifying that the current date is within the discount period parameters.
The shop owner can leave parameters empty by entering "N/A".
If a parameter is empty, then it will not be evaluated.   


There is also a general discount system. The format of this is as follows:

| Spend Amount   | Discount %      |
| :------------: | :-------------: |
| 50             | 5               |

This will give a 5% discount if the total bill exceeds £50.  
If no general discount is given, the discount item will be omitted from the receipt.  

Currently the system does not cater for a voucher provided by a customer.  
Currently the system does not take payment from a customer and give change.  

##**DOWNLOADING AND RUNNING CODE:**  

```
$ git clone https://github.com/glynester/coffee-shop-till
$ cd Coffee-Shop-Till  
$ irb
$ load './lib/app.rb'
```
Type the commands contained in the Script section into the console in an irb (or pry) session.


##Script  
Creates a shop from a json file    
Create a table of discounted items  
Sets a general spend discount    
Adds items and quantities  
Calculates the bill  
Prints a receipt  

6 * Blueberry Muffin & £4.05 (New price =  £3.81 after 6% discount)  
4 * Tea @ £3.65  
2 * Affogato @ £14.80  
67.06       (Total after individual discount on Blueberry Muffin)  
3.35        (Less: Discount on spend above £50 = 5%)  
5.5         (Add: Tax at 8.64%)  
69.21       (Total bill)  


```
load './lib/app.rb'
shop = Shop.new("./spec/test.json")  
shop.make_discount_table("Cafe Latte",4,"1/1/2016","N/A")  
shop.make_discount_table("Americano",5,"15/11/2016","31/12/2016")  
shop.make_discount_table("Blueberry Muffin",6,"N/A","1/6/2017")  
shop.set_general_discount(50,5)  
shop.add_item("Blueberry Muffin",6)  
shop.add_item("Tea",4)  
shop.add_item("Affogato",2)  
shop.calculate_bill  
print shop.show_receipt  
```


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Till tech test
==============

We want to sell tills to a local hipster coffee shop who are finally embracing the 21st century. We need a new till to replace their vintage machines - unfortunately, hipster staff are too cool to learn a new system, so we need you to build something that they will understand.

Specification
-------------

This is what a sample receipt looks like:

![sample receipt](https://www.dropbox.com/s/54606e6ie75us2y/receipt.jpg?raw=1 alt="Sample Receipt" )

Version 1
---------

Implement a system that contains the business logic to produce receipts similar to this, based on a `json` price list and test orders. A sample `.json` [file](hipstercoffee.json) has been provided with the list of products sold at this particular coffee shop.

Here are some sample orders you can try - whether you use this information is up to you:

> **Jane**  
> 2 x Cafe Latte  
> 1 x Blueberry Muffin  
> 1 x Choc Mudcake  
>
> **John**  
> 4 x Americano  
> 2 x Tiramisu  
> 5 x Blueberry Muffin  

Your receipt must calculate and show the correct amount of tax (in this shop's case, 8.64%), as well as correct line totals and total amount. Do not worry about calculating discounts or change yet. Consider what output formats may be suitable.

Version 2
---------

- Add functionality to take payment and calculate correct change.  
- Add functionality to handle discounts - in this example, a 5% discount on orders over $50, and a 10% muffin discount.

Version 3
---------

Implement a user interface that can actually be used as a till.

You may use whatever technologies you see fit.
