#lang planet neil/sicp

;;Solution heavily influenced by Bill the Lizard's work here: http://www.billthelizard.com/2011/06/sicp-242-243-n-queens-problem.html

;;helpers
(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define empty-board nil)

(define (adjoin-position row col positions)
   (append (list (make-position row col)) positions))

(define (make-position row col)
   (cons row col))

(define (get-row position)
  (car position))

(define (get-column position)
  (cdr position))

(define (attacks? q1 q2)
  (or (= (get-row q1) (get-row q2))
      (= (abs (- (get-row q1) (get-row q2)))
         (abs (- (get-column q1) (get-column q2))))))

(define (safe? col positions)
   (let ((kth-queen (car positions))
         (other-queens (cdr positions)))
     
   (define (iter q board)
     (or (null? board)
         (and (not (attacks? q (car board)))
              (iter q (cdr board)))))
   (iter kth-queen other-queens)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) 
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position 
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 1)