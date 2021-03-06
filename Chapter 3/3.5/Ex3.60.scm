#lang racket

(define (mul-series s1 s2)
  (cons-stream 
   (* (stream-first s1) (stream-first s2))
   (add-streams (scale-stream (stream-rest s2) (stream-first s1))
                (mul-series (stream-rest s1) s2))))