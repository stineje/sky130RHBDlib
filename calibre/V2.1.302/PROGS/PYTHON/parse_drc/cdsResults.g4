grammar cdsResults;

/*
 * Parser Rules
 */

cds_results : rule_res* EOF ;

rule_res     : (rulename annotate_res | '"' resolution '"' grid) NL ; 

rulename     : '"' RULENAME '"' ;

annotate_res : '(' annotate+ ')' ;

annotate     : '(' bbox '"' result '"' ')' ; 

bbox         : '(' '(' lx ly ')' '(' ux uy ')' ')' ;

lx           : NUMBER ;

ly           : NUMBER ;

ux           : NUMBER ;

uy           : NUMBER ;

result       : 'PASS' | 'FAIL' ;

resolution   : '_RESOLUTION' ;

grid         : NUMBER ;

/*
 * Lexer Rules
 */

RULENAME   : [A-Za-z] ~[ \t\n\r"]* ;
NUMBER     : '-'? [0-9]+ ('.' [0-9]+)? ;
WS         : (' ' | '\t')+ -> skip ;
NL         : ('\r'? '\n' | '\r')+ ;
