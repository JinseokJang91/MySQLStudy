USE SAKILA;

/* 2. 날짜/시간 함수 */
-- 현재 날짜 및 시간
SELECT NOW() AS current_data_time;

-- 현재 날짜
SELECT CURDATE() AS current_dt;

-- 현재 시간
SELECT CURTIME() AS current_ti;

-- 날짜에 간격 추가
SELECT rental_date, DATE_ADD(rental_date, INTERVAL 7 DAY) AS return_date
  FROM rental
 LIMIT 10;

-- 날짜에서 간격 빼기
SELECT rental_date, DATE_SUB(rental_date, INTERVAL 7 DAY) AS earlier_date
  FROM rental
 LIMIT 10;

-- 날짜 특정 필드 추출 (EXTRACT)
-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
SELECT payment_date, EXTRACT(YEAR FROM payment_date) AS payment_year
  FROM payment
 LIMIT 10;

-- 날짜 특정 필드 추출
-- YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
SELECT YEAR(payment_date) AS payment_year
	 , MONTH(payment_date) AS payment_month
     , DAY(payment_date) AS payment_day
     , HOUR(payment_date) AS payment_hour
     , MINUTE(payment_date) AS payment_minute
     , SECOND(payment_date) AS payment_second
  FROM payment
 LIMIT 10;

-- 일요일부터 시작해 몇 번째 요일인지 반환
-- 1(일요일), 2(월요일), ..., 7(토요일)
SELECT payment_date
     , DAYOFWEEK(payment_date) AS payment_dayofweek, COUNT(*) AS cnt
  FROM payment
GROUP BY payment_date, payment_dayofweek;

-- 해당 월의 몇 번째 일인지 반환
SELECT payment_date
     , DAYOFMONTH(payment_date) AS payment_dayofmonth, COUNT(*) AS cnt
  FROM payment
GROUP BY payment_date, payment_dayofmonth;

-- 해당 년도의 몇 번째 일인지 반환
SELECT payment_date
     , DAYOFYEAR(payment_date) AS payment_dayofyear, COUNT(*) AS cnt
  FROM payment
GROUP BY payment_date, payment_dayofyear;

-- 두 날짜 또는 시간 사이의 차이 계산
SELECT rental_date
     , return_date
     , TIMESTAMPDIFF(DAY, rental_date, return_date) AS rental_days
  FROM rental
 LIMIT 10;

SELECT rental_date
     , return_date
     , TIMESTAMPDIFF(HOUR, rental_date, return_date) AS rental_hours
  FROM rental
 LIMIT 10;

-- 날짜 또는 시간을 특정 형식의 문자열로 변환
 -- %Y : 4자리 연도를 표시합니다 (예: 2024).
--  %y : 연도의 마지막 두 자리를 표시합니다 (예: 24).
--  %M : 영문 월 이름을 표시합니다 (예: January).
--  %m : 월을 두 자리 숫자로 표시합니다 (01부터 12까지).
--  %c : 월을 한 자리 숫자로 표시합니다 (1부터 12까지, 필요에 따라 한 자리 또는 두 자리로 표시).
--  %D : 일을 2자리 숫자와 영문 접미사로 표시합니다 (예: 1st, 21st).
--  %d : 일을 두 자리 숫자로 표시합니다 (01부터 31까지).
--  %H : 시간을 24시간 형식의 두 자리 숫자로 표시합니다 (00부터 23까지).
--  %h : 시간을 12시간 형식의 두 자리 숫자로 표시합니다 (01부터 12까지).
--  %l : 시간을 12시간 형식의 한 자리 또는 두 자리 숫자로 표시합니다 (1부터 12까지, 필요에 따라 한 자리 또는 두 자리로 표시).
--  %i : 분을 두 자리 숫자로 표시합니다 (00부터 59까지).
--  %s : 초를 두 자리 숫자로 표시합니다 (00부터 59까지).
SELECT rental_id
	 , rental_date
	 , DATE_FORMAT(rental_date, '%Y-%m-%d') AS formatted_rental_date
     , DATE_FORMAT(rental_date, '%y/%M/%D %l:%i:%s') AS formatted_rental_date2
  FROM rental
 LIMIT 10;


/* 기본 연습문제 */
-- 4
SELECT return_date, DATE_ADD(return_date, INTERVAL 5 DAY) AS expected_return_date
  FROM rental
 WHERE return_date >= '2005-09-01'; -- 2006-01-01 이후 데이터 없어서 조건 변경

-- 4
SELECT return_date, DATE_ADD(return_date, INTERVAL 5 DAY) AS expected_return_date
  FROM rental
 WHERE return_date >= DATE_FORMAT('2005-09-01', '%Y-%m-%d'); -- 2006-01-01 이후 데이터 없어서 조건 변경