USE SAKILA;

/* １. 간단한　서브쿼리 */
SELECT first_name, last_name
  FROM customer
 WHERE customer_id IN (
	SELECT customer_id
      FROM payment
	 WHERE amount > (SELECT AVG(amount) FROM payment)
 );

/* 2. GROUP BY가 있는 서브쿼리 */
SELECT first_name, last_name
  FROM customer
 WHERE customer_id IN (
	SELECT customer_id
      FROM payment
  GROUP BY customer_id
    HAVING COUNT(*) > ( /* 평균 결제 횟수보다 많은 결제를 한 고객 */
		SELECT AVG(payment_count) /* 고객들의 결제 횟수 평균치 */
          FROM (
			SELECT COUNT(*) AS payment_count /* 고객들의 결제 횟수 */
              FROM payment
		  GROUP BY customer_id
          ) AS payment_counts /* FROM절 서브쿼리는 alias 필수 */
    )
 );

/* 3. 최대값을 가진 행 찾기 */
SELECT first_name, last_name
  FROM customer
 WHERE customer_id = (
	SELECT customer_id
      FROM (
		SELECT customer_id, COUNT(*) AS payment_count /* 고객별 결제 횟수 */
          FROM payment
	  GROUP BY customer_id
      ) AS payment_counts
ORDER BY payment_count DESC /* 결제횟수 가장 많은 순서대로 */
 LIMIT 1 /* 한 명만 출력 */
 );

/* 4. 상관 서브쿼리 */
SELECT P.customer_id, P.amount, P.payment_date
  FROM payment P
 WHERE P.amount > ( /* 고객별 자신의 결제 금액 평균보다 큰 결제한 경우 */
	SELECT AVG(amount) /* 고객별 결제 금액 평균 */
      FROM payment
	 WHERE customer_id = P.customer_id
 );


/* 기본 연습문제 */
-- 1
SELECT title, length
  FROM film
 WHERE length > (SELECT AVG(length) FROM film) -- 평균 영화길이는 115.2720
;


-- 2
SELECT first_name, last_name
  FROM customer
 WHERE customer_id IN (
	SELECT customer_id
	  FROM rental
	GROUP BY customer_id
	HAVING COUNT(*) > (
		SELECT AVG(rental_count)
		  FROM (
				SELECT customer_id, COUNT(*) AS rental_count
				  FROM rental
			  GROUP BY customer_id
		  ) AS rental_counts
	)
 )
;

-- 3
SELECT first_name, last_name
  FROM customer
 WHERE customer_id = (
	SELECT customer_id
	  FROM (
		SELECT customer_id, COUNT(*) AS rental_count
		  FROM rental
	  GROUP BY customer_id
	  ) AS rental_counts
	ORDER BY rental_count DESC
	LIMIT 1
 );

-- 4
SELECT C.first_name, C.last_name, F.title, F.length
  FROM customer C
  JOIN rental R ON R.customer_id = C.customer_id
  JOIN inventory I ON I.inventory_id = R.inventory_id
  JOIN film F ON F.film_id = I.film_id
 WHERE F.length > (
	SELECT AVG(FIL.length)
      FROM film FIL
	  JOIN inventory INV ON INV.film_id = FIL.film_id
      JOIN rental REN ON REN.inventory_id = INV.inventory_id
	 WHERE REN.customer_id = C.customer_id
 );