grammar drcResults;

// Calibre ASCII DRC result file format is a super set of PVS ASCII DRC result file format

/*
 * Parser Rules
 */

deck_results : header NL* rule_res+ NL* EOF ;

header       : top_cell db_precision NL ;

rule_res     : (rule_check NL 
                drc_count orig_drc_count {self.DRC_orig_drc_count = int($orig_drc_count.text)} check_text_lines {self.DRC_check_text_lines = int($check_text_lines.text)} date NL 
                (check_text | NL) 
                (drc_errors | NL))
             | (rdbs_check NL 
                drc_count orig_drc_count check_text_lines {self.DRC_check_text_lines = int($check_text_lines.text)} date NL 
                (rdb_errors | NL)) ;




top_cell           : WORD ;

db_precision       : NUMBER ;

rule_check         : RULENAME | WORD ; 

rdbs_check         : 'DENSITY_RDBS' | 'NET_AREA_RATIO_RDBS' | 'DRC_RDBS' | 'DBCLASSIFY_RDBS' ;

drc_count          : NUMBER ;

orig_drc_count     : NUMBER ;

check_text_lines   : NUMBER ;

rdb_name           : WORD | RULENAME ;

rdb_count          : NUMBER ;

check_text         : ({if self.DRC_check_text_lines == 0: break} (MONTH | WORD | RULENAME | OTHER | NUMBER | rdbs_check | ':' | '-')+ NL {self.DRC_check_text_lines = self.DRC_check_text_lines - 1})* ; 

rdb_errors         : ({if self.DRC_check_text_lines == 0: break} rdb_name rdb_count NL {self.DRC_check_text_lines = self.DRC_check_text_lines - 1})* ; 

drc_errors         : ({if self.DRC_orig_drc_count == 0: break} (drc_edge | drc_poly) {self.DRC_orig_drc_count = self.DRC_orig_drc_count - 1})* ; 

drc_edge           : edge drc_ordinal drc_point_count {self.DRC_drc_point_count = int($drc_point_count.text)} NL drc_e_points ; 

drc_poly           : poly drc_ordinal drc_point_count {self.DRC_drc_point_count = int($drc_point_count.text)} NL drc_p_points ; 

drc_ordinal        : NUMBER ; 

drc_point_count    : NUMBER ; 

drc_e_points       : ({if self.DRC_drc_point_count == 0: break} drc_e_x1 drc_e_y1 drc_e_x2 drc_e_y2 NL {self.DRC_drc_point_count = self.DRC_drc_point_count - 1})* ; 

drc_p_points       : ({if self.DRC_drc_point_count == 0: break} drc_p_x1 drc_p_y1 NL {self.DRC_drc_point_count = self.DRC_drc_point_count - 1})* ; 

drc_e_x1           : NUMBER ;

drc_e_y1           : NUMBER ;

drc_e_x2           : NUMBER ;

drc_e_y2           : NUMBER ;

drc_p_x1           : NUMBER ;

drc_p_y1           : NUMBER ;

month              : MONTH ; 

day                : NUMBER ;

hour               : NUMBER ;

minute             : NUMBER ;

sec                : NUMBER ;

year               : NUMBER ;

date               : month day hour ':' minute ':' sec year ;

edge               : WORD ;

poly               : WORD ;


/*
 * Lexer Rules
 */

fragment J          : ('J' | 'j') ;
fragment F          : ('F' | 'f') ;
fragment M          : ('M' | 'm') ;
fragment A          : ('A' | 'a') ;
fragment S          : ('S' | 's') ;
fragment O          : ('O' | 'o') ;
fragment N          : ('N' | 'n') ;
fragment D          : ('D' | 'd') ;
fragment JAN        : [ \t]+ J 'an' [ \t]+ ;
fragment FEB        : [ \t]+ F 'eb' [ \t]+ ;
fragment MAR        : [ \t]+ M 'ar' [ \t]+ ;
fragment APR        : [ \t]+ A 'pr' [ \t]+ ;
fragment MAY        : [ \t]+ M 'ay' [ \t]+ ;
fragment JUN        : [ \t]+ J 'un' [ \t]+ ;
fragment JUL        : [ \t]+ J 'ul' [ \t]+ ;
fragment AUG        : [ \t]+ A 'ug' [ \t]+ ;
fragment SEP        : [ \t]+ S 'ep' [ \t]+ ;
fragment OCT        : [ \t]+ O 'ct' [ \t]+ ;
fragment NOV        : [ \t]+ N 'ov' [ \t]+ ;
fragment DEC        : [ \t]+ D 'ec' [ \t]+ ;

MONTH      : (JAN | FEB | MAR | APR | MAY | JUN | JUL | AUG | SEP | OCT | NOV | DEC) ;
WORD       : [A-Za-z] [A-Za-z_0-9]* ;
RULENAME   : [A-Za-z] ~[ \t\n\r]* ;
OTHER      : ~[A-Za-z0-9 \t\n\r:-] ~[ \t\n\r]* ;
NUMBER     : '-'? [0-9]+ ;
WS         : (' ' | '\t')+ -> skip ;
NL         : ('\r'? '\n' | '\r')+ ;
