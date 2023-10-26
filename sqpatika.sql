-- ödev 10
-- SORU 1: city tablosu ile country tablosunda bulunan şehir (city) ve ülke (country) isimlerini birlikte görebileceğimiz LEFT JOIN sorgusunu yazınız.
SELECT city.city, country.country FROM city
LEFT JOIN country ON city.country_id = country.country_id;

-- SORU 2: customer tablosu ile payment tablosunda bulunan payment_id ile customer tablosundaki first_name ve last_name isimlerini birlikte görebileceğimiz RIGHT JOIN sorgusunu yazınız.
SELECT payment.payment_id, customer.first_name, customer.last_name FROM customer
RIGHT JOIN payment ON customer.customer_id = payment.customer_id;

-- SORU 3: customer tablosu ile rental tablosunda bulunan rental_id ile customer tablosundaki first_name ve last_name isimlerini birlikte görebileceğimiz FULL JOIN sorgusunu yazınız.
SELECT rental.rental_id, customer.first_name, customer.last_name FROM rental
FULL JOIN customer ON rental.customer_id = customer.customer_id;

-- ödev 11
-- SORU 1: actor ve customer tablolarında bulunan first_name sütunları için tüm verileri sıralayalım.
(SELECT first_name FROM actor)
UNION
(SELECT first_name FROM customer);

-- SORU 2: actor ve customer tablolarında bulunan first_name sütunları için kesişen verileri sıralayalım.
(SELECT first_name FROM actor)
INTERSECT
(SELECT first_name FROM customer);

-- SORU 3: actor ve customer tablolarında bulunan first_name sütunları için ilk tabloda bulunan ancak ikinci tabloda bulunmayan verileri sıralayalım.
(SELECT first_name FROM actor)
EXCEPT
(SELECT first_name FROM customer);

-- SORU 4: İlk 3 sorguyu tekrar eden veriler için de yapalım.
(SELECT first_name FROM actor)
UNION ALL
(SELECT first_name FROM customer);

(SELECT first_name FROM actor)
INTERSECT ALL
(SELECT first_name FROM customer);

(SELECT first_name FROM actor)
EXCEPT ALL
(SELECT first_name FROM customer);

-- ödev 12
-- SORU 1: film tablosunda film uzunluğu length sütununda gösterilmektedir. Uzunluğu ortalama film uzunluğundan fazla kaç tane film vardır?
SELECT COUNT(*) FROM film
WHERE length > ANY
(
    SELECT AVG(length) FROM film
);

-- SORU 2: film tablosunda en yüksek rental_rate değerine sahip kaç tane film vardır?
SELECT COUNT(*) FROM film
WHERE rental_rate = ( SELECT MAX(rental_rate) FROM film );

-- SORU 3: film tablosunda en düşük rental_rate ve en düşüK replacement_cost değerlerine sahip filmleri sıralayınız.
SELECT * FROM film
WHERE rental_rate = (SELECT MIN(rental_rate) FROM film) 
      AND 
      replacement_cost = (SELECT MIN(replacement_cost) FROM film);

-- SORU 4: payment tablosunda en fazla sayıda alışveriş yapan müşterileri(customer) sıralayınız.
SELECT customer_id, COUNT(*) FROM payment
GROUP BY customer_id
ORDER BY COUNT(*) DESC;