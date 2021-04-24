#lang pl 02

;;--------------------------------------------Q1--------------------------------------------------------

#|
Exercise: Ex 2
By: Yarden Cohen 207205972
 Q1.1
 BNF for the SE language:
 <SE> ::=  <NUM> 
 | { str-app   <SE>  }
 | { str-insrt <SE>  }
 | { num2str   <SE>  }
 
<NUM> ::=  <NUMd> | <NUMc> | <NUMs> | <SE><NUMs> | <SE><NUMc> | <SE><NUMd> | <NUM><SE> | <SE><NUM> | <SE>
<DIGITd> ::= 0|1|2|3|4|5|6|7|8|9
<NUMd> ::= <DIGITd> | <NUM><DIGITd>
<DIGITc> ::= #\0| #\1| #\2| #\3| #\4| #\5| #\6| #\7| #\8| #\9
<NUMc> ::= <DIGITc> | <NUMc><DIGITc>
<NUMs> ::= (string <NUMc>) | "<NUMd>"
  Q1.2
( string-append "45" ( number->string ( string-length "0033344" )) ( string #\1 #\2 #\4 ))
<SE> => { str-app   <SE>  }
     => { str-app   <NUM> }
     => { str-app   <SE><NUMs> }
     => { str-app    <SE>(string <NUMc>) }
     => { str-app    <SE>( string #\1 #\2 #\4 ) }
     => { str-app    <NUM><SE>( string #\1 #\2 #\4 ) }
     => { str-app    <NUM> { num2str   <SE>  }( string #\1 #\2 #\4 ) }
     => { str-app    <NUM> { num2str   ( string-length "0033344" )  }( string #\1 #\2 #\4 ) }
     => { str-app    <NUM> { num2str   7  }( string #\1 #\2 #\4 ) }
     => { str-app    <NUMs> { num2str   7  }( string #\1 #\2 #\4 ) }
     => { str-app    "<NUMd>" { num2str   7  }( string #\1 #\2 #\4 ) }
     => { str-app    "45" { num2str   7  }( string #\1 #\2 #\4 ) }
( string-append "333" ( string-insert "1357" #\4 66 )  ( string #\5 #\7 #\9 )) 
<SE> => { str-app   <SE>  }
     => { str-app   <NUM> }
     => { str-app   <SE><NUMs> }
     => { str-app   <SE>(string <NUMc>) }
     => { str-app   <SE>(string #\5 #\7 #\9 ) }
     => { str-app   <SE>(string #\5 #\7 #\9 ) }
     => { str-app   <NUM><SE>(string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <SE>  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <NUM>  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <SE><NUMd>  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <SE><NUMc> 66  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <NUM> #\4 66  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt <NUMs> #\4 66  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUM> { str-insrt "1357" #\4 66  } (string #\5 #\7 #\9 ) }
     => { str-app   <NUMs> { str-insrt "1357" #\4 66  } (string #\5 #\7 #\9 ) }
     => { str-app   "333" { str-insrt "1357" #\4 66  } (string #\5 #\7 #\9 ) }
     
( string-append ( number->string 156879) ( string-insert "1357" #\4 66 ) )
<SE> => { str-app   <SE>  }
     => { str-app   <NUM> }
     => { str-app   <NUM><SE> }
     => { str-app   <NUM> { str-insrt <SE>  } }
     => { str-app   <NUM> { str-insrt <SE><NUMd>  } }     
     => { str-app   <NUM> { str-insrt <SE> 66  } }
     => { str-app   <NUM> { str-insrt <SE><NUMc> 66  } }
     => { str-app   <NUM> { str-insrt <SE> #\4 66  } }
     => { str-app   <NUM> { str-insrt <NUMs> #\4 66  } }
     => { str-app   <NUM> { str-insrt "<NUMd>" #\4 66  } }
     => { str-app   <NUM> { str-insrt "1357" #\4 66  } }
     => { str-app   <SE> { str-insrt "1357" #\4 66  } }
     => { str-app   { num2str   <SE>  } { str-insrt "1357" #\4 66  } }
     => { str-app   { num2str   <NUMd>  } { str-insrt "1357" #\4 66  } }
     => { str-app   { num2str   156879  } { str-insrt "1357" #\4 66  } }
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


#|
-check the tests that eran send------------
- if need adding test to poly and polyX---------
-adding end cases tests to createPolynomial---------
ערן:
שלום לכולם,
עקב שאלות שעלו, הוספתי דוגמאות לשאלה 3. 
בפרט, הביטויים הבאים חוקיים:
"{{poly {/ 4 2} {- 4 1}} {{- 8 4}}}"
"{{poly {+ 0 1} 1 {* 0 9}} {{- 4 5} 3 {/ 27 9}}}"
והטסטים הבאים צריכים להצליח.
(test (run "{{poly {/ 4 2}  {- 4 1}} {{- 8 4}}}")
=> '(14))
(test (run "{{poly {+ 0 1} 1 {* 0 9}} {{- 4 5} 3 {/ 27 9}}}")
=> '(0 4 4))
|#


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
|#

(define-type PLANG [Poly (Listof AE) (Listof AE)])
 (define-type AE
 [Num Number]
 [Add AE AE]
 [Sub AE AE]
 [Mul AE AE]
 [Div AE AE])

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

 (: parse : String -> PLANG)
 ;; parses a string containing a PLANG expression to a PLANG AST
 (define (parse str)
 (let ([code (string->sexpr str)])
 (parse-sexpr-to-PLANG code)))


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



