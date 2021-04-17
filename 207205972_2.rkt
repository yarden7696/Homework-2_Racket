#lang pl 02

;;--------------------------------------------Q1--------------------------------------------------------

#|
Exercise: Ex 2
By: Yarden Cohen

 Q1.1

 BNF for the SE language:
 <SE> ::=  <NUM> 
 | { str-app   <SE>  }
 | { str-insrt <SE>  }
 | { num2str   <SE>  }
 

<NUM> ::=  <NUMd> | <NUMc> | <NUMs> | <SE><NUMs> | <SE><NUMc> | <SE><NUMd> | <NUM><SE> | <SE><NUM>

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
|# 
