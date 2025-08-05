USE SAKILA;

/* 3. 숫자 함수 */
-- 절대값
SELECT amount, ABS(-payment.amount) AS absolute_amount
  FROM payment
 LIMIT 10;

-- 올림
SELECT amount, CEIL(amount) AS ceiling_amount
  FROM payment
 LIMIT 10;

-- 내림
SELECT amount, FLOOR(amount) AS floor_amount
  FROM payment
 LIMIT 10;

-- 제곱근
SELECT length, SQRT(length) AS sqrt_length
  FROM film
 LIMIT 10;

/* 기본 연습문제 */
-- 5 절대값
SELECT amount, ABS(-amount) AS abs_amount -- 마이너스 값이 없어서 강제 마이너스화
  FROM payment
 WHERE amount < 5;

-- 6 제곱근
SELECT length, SQRT(length) AS pow_length
  FROM film
 WHERE length > 120;

-- 7 반올림
SELECT amount, ROUND(amount) AS round_amount
  FROM payment;