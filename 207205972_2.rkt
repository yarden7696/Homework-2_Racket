#lang pl 02

;;--------------------------------------------Q1--------------------------------------------------------

#|
Exercise: Ex 2
By: Yarden Cohen 207205972

Q1.1

 BNF for the SE language:
 <SE> ::=   <NUMd>  (1)
         |  <NUMs>  (2)
         |  <DIGITc>(3)


<DIGITd> ::= 0 (4)
           |1 (5)
           |2 (6)
           |3 (7)
           |4 (8)
           |5 (9)
           |6 (10)
           |7 (11)
           |8 (12)
           |9 (13)

<NUMd> ::= <DIGITd> (14)
          | <NUMd><DIGITd> (15) 
          | ( string-length <NUMs> ) (16) 


<DIGITc> ::= #\0(17)
          | #\1 (18)
          | #\2 (19)
          | #\3 (20)
          | #\4 (21)
          | #\5 (22) 
          | #\6 (23)
          | #\7 (24)
          | #\8 (25)
          | #\9 (26)

<NUMc> ::= <DIGITc> (27)
        | <NUMc><DIGITc> (28)


<NUMs> ::= "<NUMd>" (29)
        | (string <NUMc>) (30)
        | (number->string <NUMd>) (31)
        | (string-insert <NUMs> <DIGITc> <NUMd>) (32)
        | (string-append <strExp>) (33)

<strExp> ::= <NUMs> (34)
        | <NUMs><strExp> (35)


 Q1.2

(string-append "45" ( number->string ( string-length "0033344" )) ( string #\1 #\2 #\4 ))
<SE> => <NUMs>  (2)
     => (string-append <strExp>) (33)
     => (string-append <NUMs> <strExp>) (35)
     => (string-append "<NUMd>" <strExp>) (29)
     => (string-append "<NUMd><DIGITd>" <strExp>) (15)
     => (string-append "<NUMd>5" <strExp>)  (9)
     => (string-append "<DIGITd>5" <strExp>) (14)
     => (string-append "45" <NUMs><strExp>)  (35)
     => (string-append "45" (number->string <NUMd>) <strExp>))  (31)
     => (string-append "45" (number->string ( string-length <NUMs>) <strExp>)) (16)
     => (string-append "45" (number->string ( string-length "<NUMd>") <strExp>)) (29)
     => (string-append "45" (number->string ( string-length "<NUMd><DIGITd>") <strExp>)) (15)x 7 times
     => (string-append "45" (number->string ( string-length "0033344") (string <NUMc>))) (30)
     => (string-append "45" (number->string ( string-length "0033344") (string <NUMc><DIGITc>))) (28)
     => (string-append "45" (number->string ( string-length "0033344") (string <NUMc> #\4))) (21)
     => (string-append "45" (number->string ( string-length "0033344") (string <NUMc><DIGITc> #\4))) (28)
     => (string-append "45" (number->string ( string-length "0033344") (string <NUMc> #\2 #\4))) (19)
     => (string-append "45" (number->string ( string-length "0033344") (string <DIGITc> #\2 #\4))) (27)
     => (string-append "45" (number->string ( string-length "0033344") (string #\1 #\2 #\4))) (18)




( string-append "333" ( string-insert "1" #\4 6 )  ( string #\5 )) 
<SE> => <NUMs>  (2)
     => (string-append <strExp>) (33)
     => (string-append <NUMs><strExp>) (35)
     => (string-append "<NUMd>" <strExp>) (29)
     => (string-append "<NUMd><DIGITd>" <strExp>) (15)x 2 times and (14)x1 time
     => (string-append "333" <NUMs><strExp>) (35)
     => (string-append "333" (string-insert <NUMs> <DIGITc> <NUMd>) <strExp>) (32)
     => (string-append "333" (string-insert "<NUMd>" <DIGITc> <NUMd>) <strExp>) (29)
     => (string-append "333" (string-insert "<DIGITd>" <DIGITc> <NUMd>) <strExp>) (14)
     => (string-append "333" (string-insert "1" <DIGITc> <NUMd>) <strExp>) (5)
     => (string-append "333" (string-insert "1" #\4 <NUMd>) <strExp>) (21)
     => (string-append "333" (string-insert "1" #\4 <DIGITd>) <strExp>) (14)
     => (string-append "333" (string-insert "1" #\4 6) <strExp>) (10)
     => (string-append "333" (string-insert "1" #\4 6) <NUMs>) (34)
     => (string-append "333" (string-insert "1" #\4 6) (string <NUMc>)) (30)
     => (string-append "333" (string-insert "1" #\4 6) (string <DIGITc>)) (27)
     => (string-append "333" (string-insert "1" #\4 6) (string #\5)) (22)


(string-append ( number->string 15) ( string-insert "7" #\9 66 ))
<SE> => <NUMs>  (2)
     => (string-append <strExp>) (33)
     => (string-append <NUMs><strExp>) (35)
     => (string-append (number->string <NUMd>) <strExp>) (31)
     => (string-append (number->string <NUMd><DIGITd>) <strExp>) (15)
     => (string-append (number->string <NUMd>5) <strExp>) (9)
     => (string-append (number->string <DIGITd>5) <strExp>) (14)
     => (string-append (number->string 15) <strExp>) (5)
     => (string-append (number->string 15) <NUMs>) (34)
     => (string-append (number->string 15) (string-insert <NUMs> <DIGITc> <NUMd>)) (32)
     => (string-append (number->string 15) (string-insert "<NUMd>" <DIGITc> <NUMd>)) (29)
     => (string-append (number->string 15) (string-insert "<DIGITd>" <DIGITc> <NUMd>)) (14)
     => (string-append (number->string 15) (string-insert "7" <DIGITc> <NUMd>)) (11)
     => (string-append (number->string 15) (string-insert "7" #\9 <NUMd>)) (26)
     => (string-append (number->string 15) (string-insert "7" #\9 <NUMd><DIGITd>)) (15)
     => (string-append (number->string 15) (string-insert "7" #\9 <NUMd>6)) (10)
     => (string-append (number->string 15) (string-insert "7" #\9 <DIGITd>6)) (14)
     => (string-append (number->string 15) (string-insert "7" #\9 66)) (10)

|#

;;--------------------------------------------Q2--------------------------------------------------------

#|
input: some number
output: calc (num)^2
This is an auxiliary function that calculates a number squared |#
(: square : Number -> Number)
(define(square num)
   (* num num))  

#|
input: list of numbers
output: number which is the sum of the squares of all of the numbers in the list
This function uses `foldl` when-
`proc` is : '+'
`init` starts from 0
`lst` is a list that each element in it used the square function when square uses a map.
map runs square function on each of the list elements.
This question was not difficult for me and took me an average of 30 minutes.
The difficulty was mainly the understanding how map and foldl work and how to combine them together.|#
(: sum-of-squares : (Listof Number) -> Number)
(define(sum-of-squares lst)
  (let ([afterSquare (map square lst) ])
    (foldl + 0 afterSquare)))


(test (square 5) => 25)
(test (square -4) => 16)
(test (square 4) => 16)
(test (square 0) => 0)

(test (sum-of-squares '()) => 0)
(test (sum-of-squares '(5)) => 25)
(test (sum-of-squares '(2 6)) => 40)
(test (sum-of-squares '(1 2 3)) => 14)
(test (sum-of-squares '(-1 2 -3)) => 14)
(test (sum-of-squares '(-1 -2 -3)) => 14)
(test (sum-of-squares '(0 1 2 3 0)) => 14)
(test (sum-of-squares '(2 2 2 2 2 2)) => 24)


;;--------------------------------------------Q3--------------------------------------------------------


#| Q3.a
input: list of numbers
output: the output is function, the returned function takes a number x and return the value of
the polynomial.
This function called polyX function (with the number x it got, power initialed 0 and initialed acuum 0)
and polyX called poly function that boths of them in createPolynomial
function.
This question took me an average of about two hours.
The difficulty was to understand the output of the function and to understand the question itself. |#
(: createPolynomial : (Listof Number) -> (Number -> Number))
(define (createPolynomial coeffs)
  
 (: poly : (Listof Number) Number Integer Number -> Number)
 (define (poly argsL x power accum)
 (if (null? argsL)
     accum ;;if the list is empty-> return accum we got
     (poly  (rest argsL) x (+ power 1) (+ accum (* (expt x power) (first argsL))))));;else- the list is not empty
  
 (: polyX : Number -> Number)
 (define (polyX x)
   (poly coeffs x 0 0)) ;; polyX call poly function with the number x it got
  polyX ;; this the body of createPolynomial function. in the body i called polyX function that called poly function
  )


(define p2468 (createPolynomial '(2 4 6 8)))
(test (p2468 0) =>(+ (* 2 (expt 0 0)) (* 4 (expt 0 1)) (* 6 (expt 0 2)) (* 8(expt 0 3))))
(test (p2468 9) => (+ (* 2 (expt 9 0)) (* 4 (expt 9 1)) (* 6 (expt 9 2)) (* 8(expt 9 3))))
(test (p2468 21) => (+ (* 2 (expt 21 0)) (* 4 (expt 21 1)) (* 6(expt 21 2)) (* 8 (expt 21 3))))
(test (p2468 -21) => (+ (* 2 (expt -21 0)) (* 4 (expt -21 1)) (* 6(expt -21 2)) (* 8 (expt -21 3))))

(define p-576 (createPolynomial '(-5 7 6)))
(test (p-576 31) => (+ (* -5 (expt 31 0)) (* 7 (expt 31 1)) (* 6(expt 31 2))))

(define p_0 (createPolynomial '()))
(test (p_0 4) => 0)


#| Q3.b.i
This question took me an average of about 10 minutes and i barely faced any difficulties.
Eventually AE is a number so that it can be chained to AEs and
thus get the {{ 𝒑𝒐𝒍𝒚 𝑪𝟏 𝑪𝟐 … 𝑪𝒌} {𝑷𝟏 𝑷𝟐 … 𝑷𝓵}}

 BNF for the PLANG language:
 The grammar:
 <PLANG> :: = {{poly <AEs> }{<AEs> }}
 <AEs> :: = <AE> | <AE> <AEs>
 <AE> ::= <num>  As we learned in class 
       | { + <AE> <AE> } 
       | { - <AE> <AE> } 
       | { * <AE> <AE> } 
       | { / <AE> <AE> }
|#


#| Q3.b.ii
This question took me an average of about 2 hours.
The difficulty was how to enable the 'parse-sexpr' function on the 2 lists.
Finally I remembered that in question 2 i used 'map' and i think using it in this question can also help. |#

#|PLANG constructed from the reserved word 'poly' and two lists of AE
The first list is list of coefficients and the second is a list of numbers that we will place in X |#
(define-type PLANG [Poly (Listof AE) (Listof AE)])

 (define-type AE
 [Num Number]
 [Add AE AE]
 [Sub AE AE]
 [Mul AE AE]
 [Div AE AE])

#|
input: Expression Sexpr
output: Expression AE
There is a check whether sexpr is of the type of +/ -/ */ :/ error
And according to this there is a call to the appropriate constructor
|#
 (: parse-sexpr : Sexpr -> AE)
 ;; to convert s-expressions into AEs
 (define (parse-sexpr sexpr)
 (match sexpr
 [(number: n) (Num n)]
 [(list '+ lhs rhs) (Add (parse-sexpr lhs) (parse-sexpr rhs))]
 [(list '- lhs rhs) (Sub (parse-sexpr lhs) (parse-sexpr rhs))]
 [(list '* lhs rhs) (Mul (parse-sexpr lhs) (parse-sexpr rhs))]
 [(list '/ lhs rhs) (Div (parse-sexpr lhs) (parse-sexpr rhs))]
 [else (error 'parse-sexpr "bad syntax in ~s" sexpr)]))


#|
input: String
output: PLANG
I created a function called 'parse-sexpr-to-PLANG' that receives sexpr and returns PLANG.
We declared a variable named 'code' and sent him to 'string-> sexpr' function.
The expression we received was sent to the function 'parse-sexpr-to-PLANG'.
It is necessary to return PLANG caz the 'parse' function returns PLANG. |#
 (: parse : String -> PLANG)
 ;; parses a string containing a PLANG expression to a PLANG AST
 (define (parse str)
 (let ([code (string->sexpr str)])
 (parse-sexpr-to-PLANG code)))


#|
input: Expression Sexpr
output: PLANG
There is a check whether sexpr is of the type of:
* {{'poly C1 C2...} {'()}} => Error caz the second list can not be null
* {{'poly '()} {P1 P2...}} => Error caz first list can not be null
* {{'poly C1 C2)} {P1 P2...}} => good syntax. i called 'poly' function with the left list and
    the right list. these 2 lists should be in type AE and so that i called 'parse-sexpr' function that
    return AE using map. 
    map runs 'parse-sexpr' function on each of the lists elements.
* else => we got bad syntax. |#
(: parse-sexpr-to-PLANG : Sexpr -> PLANG)
(define (parse-sexpr-to-PLANG code)
  (match code
     [(list (cons 'poly Cs) '()) (error 'parse "at least one point is required in ~s" code)]
     [(list (cons 'poly '()) (list Ps ...)) (error 'parse "at least one coefficient is required in ~s" code)]
     [(list (cons 'poly Cs) (list Ps ...)) (Poly (map parse-sexpr Cs) (map parse-sexpr Ps))]
     [else (error 'parse "bad syntax in ~s" code)]))
    
   
;; tests
(test (parse "{{poly 1 2 3} {4 6 9}}") => (Poly (list (Num 1) (Num 2) (Num 3)) (list (Num 4) (Num 6) (Num 9))))
(test (parse "{{poly -1 2 3} {4 6 -9}}") => (Poly (list (Num -1) (Num 2) (Num 3)) (list (Num 4) (Num 6) (Num -9))))
(test (parse "{{poly } {1 2} }") =error> "parse: at least one coefficient is required in ((poly) (1 2))")
(test (parse "{{poly 1 2} {} }") =error> "parse: at least one point is required in ((poly 1 2) ())")
(test (parse "{{poly 2 3} {4}}") => (Poly (list (Num 2) (Num 3)) (list (Num 4)))) 
(test (parse "{{poly 4/5} {1/2 2/3 3}}") => (Poly (list (Num 4/5)) (list (Num 1/2) (Num 2/3) (Num 3))))
(test (parse "{{poly 4/5 } {1/2 2/3 3} {poly 1 2 4} {1 2}}") =error> "parse: bad syntax in ((poly 4/5) (1/2 2/3 3) (poly 1 2 4) (1 2))")



#| Q3.b.iii
This question took me an average of about 30 minutes.
The difficulty was that i had to use the 'createPolynomial' function. |#

;; evaluates AE expressions to numbers
(: eval : AE ->  Number )
 (define (eval expr)
 (cases expr
 [(Num n) n]
 [(Add l r) (+ (eval l) (eval r))]
 [(Sub l r) (- (eval l) (eval r))]
 [(Mul l r) (* (eval l) (eval r))]
 [(Div l r) (/ (eval l) (eval r))])) 


#|
input: PLANG. so that PLANG=(Poly (Listof AE) (Listof AE))
output: Listof Number that each number on the list is a calculation of the coefficients and powers.
I called 'createPolynomial' function. i used 'map' that runs '(createPolynomial (map eval Cs))' function
on each of the (map eval Ps) elements.
|#
 (: eval-poly : PLANG -> (Listof Number))
 (define (eval-poly p-expr)
   (cases p-expr
     [(Poly Cs Ps) (map (createPolynomial (map eval Cs)) (map eval Ps))]))
  

 (: run : String -> (Listof Number))
 ;; evaluate a FLANG program contained in a string
 (define (run str)
 (eval-poly (parse str)))
  
;;tests
(test (run "{{poly 1 2 3} {1 2 3}}")=> '(6 17 34))
(test (run "{{poly 4 2 7} {1 4 2}}")=> '(13 124 36))
(test (run "{{poly 1/2 } {1/2 2/3 3}}")=> '(1/2 1/2 1/2))
(test (run "{{poly 2 3} {3}}") => '(11))
(test (run "{{poly 1 1 0} {-1 -1}}")=> '(0 0))

(test (eval(Add (Num 2) (Num 3)))=> 5) 
(test (eval(Sub (Num 4) (Num 4)))=> 0)
(test (eval(Mul (Num 2) (Num 3)))=> 6)
(test (eval(Div (Num 2) (Num 1)))=> 2) 
