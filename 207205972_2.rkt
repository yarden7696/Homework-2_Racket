#lang pl 02


#| BNF for the SE language:
 <SE> ::= { <FinalNUM> }
 | { + <SE> <SE> }
 | { - <AE> <SE> }
 | { * <SE> <SE> }
 | { / <SE> <SE> }


<FinalNUM> ::=  <NUMd> | <NUMc> | <NUMs>

<Digit> ::= 0|1|2|3|4|5|6|7|8|9
<NUMd> ::= <digit> | <NUM><digit>

<CharNum> ::= #\0| #\1| #\2| #\3| #\4| #\5| #\6| #\7| #\8| #\9
<NUMc> ::= <CharNum> | <NUMc><CharNum>

<NUMs> ::= (string <NUMc>)
|#
