USE SAKILA;

/* 1. 문자열 함수 */
-- 문자열 길이
SELECT title, LENGTH(title) AS title_length
  FROM film
 LIMIT 10;

-- 문자열 대문자 변환
SELECT UPPER(title) AS upperedcased_title
  FROM film
 LIMIT 10;

-- 문자열 소문자 변환
SELECT LOWER(title) AS loweredcased_title
  FROM film
 LIMIT 10;

-- 문자열 연결
SELECT CONCAT(first_name, ' ', last_name) AS full_name
  FROM actor
 LIMIT 10;

-- 부분 문자열 추출
SELECT SUBSTRING(description, 1, 10) AS short_description
  FROM film
 LIMIT 10;

/* 기본 연습문제 */
-- 1
SELECT *
  FROM film
 WHERE LENGTH(title) = 15;

-- 2
SELECT CONCAT(first_name, ' ', last_name) AS full_name
  FROM actor
 WHERE LOWER(first_name) = 'john';

-- 3
SELECT title
  FROM film
 WHERE SUBSTRING(description, 3, 6) = 'Action';