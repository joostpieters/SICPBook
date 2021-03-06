#lang planet neil/sicp

(define (filtered-accumulate combiner null-value term a next b filter)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter (term a)) (iter (next a) (combiner (term a) result)))
          (else (iter (next a) result))))
  (iter a null-value))

;;HELPERS
(define (inc x) (+ x 1))
(define (identity x) x)
(define (square x) (* x x))

;; sum of primes; prime? predicate assumed to exist
(define (sum-primes a b)
  (filtered-accumulate + 0 identity a inc b prime?))

;; product of all the positive integers less than n that are relatively prime to n
;; assuming GCD procedure exists
(define (product n)
  (define (filter x) (gcd x))
  (filtered-accumulate * 1 identity 1 inc n filter))

;; sum of even numbers
(define (sum-even a b)
  (filtered-accumulate + 0 identity a inc b even?))

(sum-even 1 10)