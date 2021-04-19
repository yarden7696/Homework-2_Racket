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





