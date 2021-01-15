CREATE TABLE customer(
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(128) NOT NULL,
    customer_email VARCHAR2(255) NOT NULL , --unique?
    customer_phone VARCHAR2(12) NOT NULL,
    customer_address VARCHAR2(255) NOT NULL
    );
    
CREATE TABLE courier (
    courier_id NUMBER PRIMARY KEY,
    courier_web VARCHAR2(100) NOT NULL,
    courier_name VARCHAR2(50) NOT NULL, 
    courier_phone VARCHAR2(12) NOT NULL
    );
    
CREATE TABLE seller (
    seller_id NUMBER PRIMARY KEY,
    seller_address VARCHAR2(255) NOT NULL,
    seller_phone VARCHAR2(25) NOT NULL,
    seller_name VARCHAR2(128) NOT NULL,
    seller_email VARCHAR2(254) NOT NULL
    );
    
CREATE TABLE product_category (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(100) NOT NULL
    );
        
CREATE TABLE brand (
    brand_id NUMBER PRIMARY KEY,
    brand_name VARCHAR2(100) NOT NULL
    );
    
CREATE TABLE payment (
    payment_id NUMBER PRIMARY KEY,
    payment_date DATE DEFAULT SYSDATE NOT NULL,
    payment_type VARCHAR2(10) NOT NULL,
    amount DECIMAL(10,2) NOT NULL, --should be same as cart(total_price)
    customer_id NUMBER REFERENCES customer(customer_id) ON DELETE CASCADE 
    );
  
CREATE TABLE cart (
    cart_id NUMBER PRIMARY KEY,
    cart_status VARCHAR2(15) DEFAULT 'Processing',
    total_price DECIMAL(10,2) NOT NULL,--should be equal to all products in the cart [product(price) * contains_product(product_amount)]
    courier_id NUMBER REFERENCES courier(courier_id) ON DELETE CASCADE,
    payment_id NUMBER REFERENCES payment(payment_id) ON DELETE CASCADE,
    service_level VARCHAR2(25) NOT NULL,
    tracking_number VARCHAR2(40)
    );   

CREATE TABLE product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    product_count NUMBER NOT NULL CHECK (product_count >= 0), 
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), 
    seller_id NUMBER REFERENCES seller(seller_id) ON DELETE CASCADE,
    brand_id NUMBER REFERENCES brand(brand_id) ON DELETE CASCADE,
    category_id NUMBER REFERENCES product_category(category_id) ON DELETE CASCADE
    );
  
CREATE TABLE contains_product(
    product_id NUMBER REFERENCES product(product_id) ON DELETE CASCADE,
    cart_id NUMBER REFERENCES cart(cart_id) ON DELETE CASCADE,
    product_amount NUMBER CHECK (product_amount > 0), --this should be less than product_count
    PRIMARY KEY (product_id, cart_id)
    );       

/*inserting rows of mock data*/
--Customers:
INSERT INTO customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES (1, 'J Weber', 'jweber@gmail.com', '123456789', '123 main street');
INSERT INTO customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES (2, 'Ms Feeld', 'feeld@gmail.com', '555156189', '24 oak street');
INSERT INTO customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES (3, 'Mr Saad', 'saad1@gmail.com', '555999848', '33 welesely rd');
INSERT INTO customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES (4, 'Cashwan', 'cashwan@gmail.com', '555444888', '18 river rd');
INSERT INTO customer (customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES (5, 'Betty DeLile', 'bdlile@gmail.com', '555841599', '906 cam ave');

--Couriers:
INSERT INTO courier (courier_id, courier_name, courier_web, courier_phone ) VALUES (1, 'CanPost', 'canpost.ca', '180055555');
INSERT INTO courier (courier_id, courier_name, courier_web, courier_phone ) VALUES (2, 'Fedex', 'fedex.com', '18005556515');
INSERT INTO courier (courier_id, courier_name, courier_web, courier_phone ) VALUES (3, 'UPS', 'ups.com', '18005558954');

--Sellers:
INSERT INTO seller (seller_id, seller_name, seller_address, seller_phone, seller_email) VALUES (1, 'Max Computers', '123 Max Ave', '1800555755', 'contact@maxcomp.com');
INSERT INTO seller (seller_id, seller_name, seller_address, seller_phone, seller_email) VALUES (2, 'Park Vintage', 'Bud St', '9068526268', 'info@parkvintage.com');
INSERT INTO seller (seller_id, seller_name, seller_address, seller_phone, seller_email) VALUES (3, 'Min Computers', '321 Min St', '815784658', 'contact@mincomp.com');
INSERT INTO seller (seller_id, seller_name, seller_address, seller_phone, seller_email) VALUES (4, 'ToysRUs', '189 Toy Place', '18885558181', 'cs@toyrus.com');
INSERT INTO seller (seller_id, seller_name, seller_address, seller_phone, seller_email) VALUES (5, 'ABC Books', '89 John St', '8159265484', 'abc@yahoo.com');

--Product Categories:
INSERT INTO product_category (category_id, category_name) VALUES (1, 'Computer');
INSERT INTO product_category (category_id, category_name) VALUES (2, 'Clothing');
INSERT INTO product_category (category_id, category_name) VALUES (3, 'Toys');
INSERT INTO product_category (category_id, category_name) VALUES (4, 'Books');
INSERT INTO product_category (category_id, category_name) VALUES (5, 'Games');

--Brands:
INSERT INTO brand (brand_id, brand_name) VALUES (1, 'Apple');
INSERT INTO brand (brand_id, brand_name) VALUES (2, 'Microsoft');
INSERT INTO brand (brand_id, brand_name) VALUES (3, 'Hot Wheels');
INSERT INTO brand (brand_id, brand_name) VALUES (4, 'Penguin Books');
INSERT INTO brand (brand_id, brand_name) VALUES (5, 'Nintendo');
INSERT INTO brand (brand_id, brand_name) VALUES (6, 'Vintage');


--Products:
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (1, 'Apple Monitor', 20, 4000.00, 1, 1, 1);
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (2, 'Microsoft Keyboard', 50, 75.00, 2, 1, 3);
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (3, 'Hot Wheels Track Set', 15, 55.00, 3, 3, 4);
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (4, 'Coffee Table Book', 20, 10.00, 4, 4, 5);
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (5, 'Zelda', 40, 70.00, 5, 5, 4);
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (6, 'Vintage 80s Military Jacket M', 10, 25.00, 6, 2, 2);

--Payments/Carts/Contains_Product:
INSERT INTO payment (payment_id, payment_date, payment_type, amount, customer_id) VALUES (1, '2020-10-5', 'Visa', 4000.00, 1);
INSERT INTO cart (cart_id, cart_status, total_price, courier_id, payment_id, service_level, tracking_number) VALUES (1, 'Shipped', 4000.00, 1, 1, 'Regular', 'xn151890op');
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (1, 1, 1);

INSERT INTO payment (payment_id, payment_date, payment_type, amount, customer_id) VALUES (2, '2020-10-20', 'MasterCard', 125.00, 2);
INSERT INTO cart (cart_id, cart_status, total_price, courier_id, payment_id, service_level, tracking_number) VALUES (2, 'Processing', 125.00, 2, 2, 'Regular', '0605481028700');
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (3, 2, 1);
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (5, 2, 1);

INSERT INTO payment (payment_id, payment_date, payment_type, amount, customer_id) VALUES (3, '2020-10-18', 'Interac', 70.00, 3);
INSERT INTO cart (cart_id, cart_status, total_price, courier_id, payment_id, service_level, tracking_number) VALUES (3, 'Shipped', 70.00, 3, 3, 'Express', 'EX8189156');
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (6, 3, 1);

INSERT INTO payment (payment_id, payment_date, payment_type, amount, customer_id) VALUES (4, '2020-10-01', 'PayPal', 85.00, 4);
INSERT INTO cart (cart_id, cart_status, total_price, courier_id, payment_id, service_level, tracking_number) VALUES (4, 'Shipped', 85.00, 1, 4, 'Xpress', 'X81865189EN');
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (2, 4, 1);
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (4, 4, 1);

--more data
INSERT INTO product (product_id, product_name, product_count, price, brand_id, category_id, seller_id) VALUES (7, 'Vintage Nursery Rhymes Book', 5, 5.00, 6, 4, 2);
INSERT INTO payment (payment_id, payment_date, payment_type, amount, customer_id) VALUES (5, '2020-10-28', 'Apple Pay', 60.00, 5);
INSERT INTO cart (cart_id, cart_status, total_price, courier_id, payment_id, service_level, tracking_number) VALUES (5, 'Shipped', 60.00, 2, 5, 'Xpress', 'WJKX8518');
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (6, 5, 2);
INSERT INTO contains_product (product_id, cart_id, product_amount) VALUES (4, 5, 1);
/*simple queries*/
SELECT customer_name, customer_email
FROM customer
ORDER BY customer_name;

SELECT courier_name, courier_web, courier_phone
FROM courier
ORDER BY courier_name;

SELECT seller_name, seller_email, seller_phone, seller_address
FROM seller
ORDER BY seller_name;

SELECT category_name
FROM product_category
ORDER BY category_name;

SELECT brand_name
FROM brand
ORDER BY brand_name;


/*more advanced join queries */
SELECT customer_name, amount, payment_type, payment_date
FROM customer, payment
WHERE customer.customer_id = payment.customer_id
ORDER BY payment_date;

SELECT product_name, product_count, price, seller_name
FROM product, seller
WHERE product.seller_id = seller.seller_id
ORDER BY product_name;

SELECT customer_name, cart_status, tracking_number
FROM customer, cart, payment
WHERE cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
ORDER BY customer_name;

SELECT customer_name, product_name, product_amount
FROM customer, product, contains_product, cart, payment
WHERE contains_product.product_id = product.product_id
AND contains_product.cart_id = cart.cart_id
AND cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
ORDER BY customer_name;

--VIEWS
--Potential sale of product if you have a lot of extra inventory, amount of product is greater than the average product count of all products
CREATE VIEW products_to_put_on_sale (discounted_productName, discounted_productCount, original_price) AS
(SELECT product_name, product_count, price
FROM product
WHERE product_count>(
SELECT AVG(product_count)
FROM product));
--Customer that bought the most vintage jackets, could be customized to show all products top shopper
CREATE VIEW VJ_Number_One_Shopper (Number_One_Customer) AS
SELECT customer_name
FROM customer, payment, cart, contains_product
WHERE product_amount =(
SELECT MAX(product_amount)
FROM contains_product
WHERE product_id = 6)
AND product_id = 6
AND contains_product.cart_id = cart.cart_id
AND cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id;
--Customer's who's orders are still being processed
CREATE VIEW need_to_be_shipped(cust_name, cust_address, track_num, sell_name, sell_phone)AS
SELECT DISTINCT customer_name, customer_address, tracking_number, seller_name, seller_phone
FROM customer, payment, cart, contains_product, product, seller
WHERE cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
AND cart_status = 'Processing'
AND cart.cart_id = contains_product.cart_id
AND contains_product.product_id = product.product_id
AND product.seller_id = seller.seller_id

/*advanced queries for assignment 5 */
--Advanced join query
SELECT DISTINCT product_name, brand_name, category_name, seller_name
FROM product, product_category, brand, seller
WHERE product.brand_id = brand.brand_id
AND product.category_id = product_category.category_id
AND product.seller_id = seller.seller_id
ORDER BY product_name;

--Customers who bought Vintage 80s OR bought coffee table 
SELECT customer_name
FROM customer, product, contains_product, cart, payment
WHERE contains_product.product_id = product.product_id
AND contains_product.cart_id = cart.cart_id
AND cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
AND product_name = 'Vintage 80s Military Jacket M'
UNION
(SELECT customer_name
FROM customer, product, contains_product, cart, payment
WHERE contains_product.product_id = product.product_id
AND contains_product.cart_id = cart.cart_id
AND cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
AND product_name = 'Coffee Table Book');

--Aggregate function, # of items sold
SELECT product_name, COUNT(*)
FROM contains_product, product
WHERE contains_product.product_id = product.product_id
GROUP BY product_name;

--Products that cost above $20 and $70 or under
SELECT product_name
FROM product
WHERE price BETWEEN 20 AND 70; 

--Customers who have their products shipped by couriers other than Canpost
SELECT customer_name, cart_status
FROM customer, cart, payment
WHERE cart.payment_id = payment.payment_id
AND payment.customer_id = customer.customer_id
AND cart_status = 'Shipped'
AND NOT EXISTS
(SELECT *
FROM courier
WHERE courier_id = 1
AND cart.courier_id = courier.courier_id);
--Products sold by ToysRUs
SELECT product_name
FROM product
WHERE NOT EXISTS
(SELECT *
FROM seller
WHERE seller_id <> 4
AND product.seller_id = seller.seller_id);

/*drop scripts*/
--SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
