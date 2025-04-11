#!/usr/bin/python3

import sys
import os
import argparse
from antlr4 import *
from drcResultsLexer import drcResultsLexer
from drcResultsListener import drcResultsListener
from drcResultsParser import drcResultsParser
from cdsResultsLexer import cdsResultsLexer
from cdsResultsListener import cdsResultsListener
from cdsResultsParser import cdsResultsParser
from shapely.geometry import Polygon, LineString, Point

version = '0.1'

# NOTE: does not support:
# - DRC Cell Name Results
# - Properties in ASCII DRC Results Databases

class DRCErrorListener(drcResultsListener):
    def __init__(self):
        self.db = {}
        # NOTE: Points scaled to 1:1 with CDS results upon database generation
        self.orig_scale = False

    def enterHeader(self, ctx):
        self.orig_scale = float(ctx.db_precision().NUMBER().getText())

    def enterRule_check(self, ctx):
        if ctx.RULENAME():
            name = ctx.RULENAME().getText()
        elif ctx.WORD():
            name = ctx.WORD().getText()
        
        if not name in self.db:
            self.db[name] = {'e': [], 'p': []}

    def enterDrc_edge(self, ctx):
        if ctx.parentCtx.parentCtx.rule_check().RULENAME():
            name = ctx.parentCtx.parentCtx.rule_check().RULENAME().getText()
        elif ctx.parentCtx.parentCtx.rule_check().WORD():
            name = ctx.parentCtx.parentCtx.rule_check().WORD().getText()
        for x1,y1,x2,y2 in zip(ctx.drc_e_points().drc_e_x1(), ctx.drc_e_points().drc_e_y1(), ctx.drc_e_points().drc_e_x2(), ctx.drc_e_points().drc_e_y2()):
            #print('{0} {1} {2} {3}'.format(x1.NUMBER(), y1.NUMBER(), x2.NUMBER(), y2.NUMBER()))
            #self.db[name]['e'].append([[float(x1.NUMBER().getText()), float(y1.NUMBER().getText())], [float(x2.NUMBER().getText()), float(y2.NUMBER().getText())]])
            self.db[name]['e'].append(LineString([Point(float(x1.NUMBER().getText())/self.orig_scale, float(y1.NUMBER().getText())/self.orig_scale), Point(float(x2.NUMBER().getText())/self.orig_scale, float(y2.NUMBER().getText())/self.orig_scale)]))

    def enterDrc_poly(self, ctx):
        tmp = []
        if ctx.parentCtx.parentCtx.rule_check().RULENAME():
            name = ctx.parentCtx.parentCtx.rule_check().RULENAME().getText()
        elif ctx.parentCtx.parentCtx.rule_check().WORD():
            name = ctx.parentCtx.parentCtx.rule_check().WORD().getText()
        for x,y in zip(ctx.drc_p_points().drc_p_x1(), ctx.drc_p_points().drc_p_y1()):
            #print('{0} {1}'.format(x.NUMBER(), y.NUMBER()))
            tmp.append([float(x.NUMBER().getText())/self.orig_scale, float(y.NUMBER().getText())/self.orig_scale])
        #self.db[name]['p'].append(tmp)
        self.db[name]['p'].append(Polygon(tuple(tmp)))

class CDSErrorListener(cdsResultsListener):
    def __init__(self):
        self.db = {}
        self.grid = False 

    def enterRule_res(self, ctx):
        if ctx.rulename():
            name = ctx.rulename().RULENAME().getText()

            if not name in self.db:
                self.db[name] = {'result': [], 'p': []} 

            for an in ctx.annotate_res().annotate(): 
                result = an.result().getText()
                lx = float(an.bbox().lx().getText())
                ly = float(an.bbox().ly().getText())
                ux = float(an.bbox().ux().getText())
                uy = float(an.bbox().uy().getText())
                #print('{0} {1} {2} {3}'.format(lx, ly, ux, uy))

                self.db[name]['result'].append(result)
                self.db[name]['p'].append(Polygon(([ux, uy], [lx, uy], [lx, ly], [ux, ly])))

        elif ctx.resolution():
            self.grid = float(ctx.grid().NUMBER().getText())

def process_args():
    parser = argparse.ArgumentParser(description="""DRC Result Equalizer""",
                                     fromfile_prefix_chars='@',
                                     formatter_class=argparse.RawTextHelpFormatter,
                                     epilog='Please contact Mitch Levine with any questions')
    parser.add_argument('-v', '--ver', action='version', version='Version {0}'.format(version), help='Print the version\n')
    parser.add_argument('-i', '--in_drc', action='store', required=True, help='Input DRC results file.\n')
    parser.add_argument('-j', '--in_cds', action='store', required=True, help='Input CDS results file.\n')
    parser.add_argument('-o', '--out_file', action='store', required=True, help='Output DRC results file.\n')
    parser.add_argument('-t', '--type', action='store', required=True, choices=['pvs', 'calibre'], help='Type of DRC results file.\n')
    (parsed_args, unparsed_args) = parser.parse_known_args()
    return parsed_args, unparsed_args

def beautify_lisp_string(in_string):
    indent_size = 3
    add_indent = ' '*indent_size
    out_string = in_string[0]  # no indent for 1st (
    indent = ''
    for i in range(1, len(in_string)):
        if in_string[i] == '(' and in_string[i+1] != ' ':
            indent += add_indent
            out_string += "\n" + indent + '('
        elif in_string[i] == ')':
            out_string += ')'
            if len(indent) > 0:
                indent = indent.replace(add_indent, '', 1)
        else:
            out_string += in_string[i]
    return out_string

def find_match(cds_res, cds_p, drc_p, drc_e):
    match = {'result_p': [], 'cds_p': [], 'p': [], 'result_e': [], 'cds_e': [], 'e': []}
    no_match = {'result': [], 'cds_p': [], 'p': [], 'e': []}
    pass_match = {'result_p': [], 'cds_p': [], 'p': [], 'result_e': [], 'cds_e': [], 'e': []}

    if not cds_p:
        return (match, no_match, {'p': drc_p}, {'e': drc_e})
    else:
        no_match_c_ind = []

        for i,pc in enumerate(cds_p):
            found = False
            match_p_ind = []
            match_e_ind = []

            for j,pd in enumerate(drc_p):
                if pc.contains(pd):
                    if cds_res[i] == 'FAIL':
                        found = True 
                        match['result_p'].append(cds_res[i])
                        match['cds_p'].append(pc)
                        match['p'].append(pd)
                        match_p_ind.append(j)
                    elif cds_res[i] == 'PASS':
                        found = True 
                        pass_match['result_p'].append(cds_res[i])
                        pass_match['cds_p'].append(pc)
                        pass_match['p'].append(pd)
                        match_p_ind.append(j)
                    else:
                        print('ERROR: Unexpected result value {0}.'.format(cds_res[i]))
                        sys.exit()
            drc_p = [drc_p[n] for n in [m for m in range(len(drc_p)) if not m in match_p_ind]]

            for k,ed in enumerate(drc_e):
                if pc.contains(ed):
                    if cds_res[i] == 'FAIL':
                        found = True 
                        match['result_e'].append(cds_res[i])
                        match['cds_e'].append(pc)
                        match['e'].append(ed)
                        match_e_ind.append(k)
                    elif cds_res[i] == 'PASS':
                        found = True 
                        pass_match['result_e'].append(cds_res[i])
                        pass_match['cds_e'].append(pc)
                        pass_match['e'].append(ed)
                        match_e_ind.append(k)
                    else:
                        print('ERROR: Unexpected result value {0}.'.format(cds_res[i]))
                        sys.exit()
            drc_e = [drc_e[n] for n in [m for m in range(len(drc_e)) if not m in match_e_ind]]

            if not found:
                no_match_c_ind.append(i)

        no_match['p'] = drc_p
        no_match['e'] = drc_e
        no_match['result'] = [cds_res[ind] for ind in no_match_c_ind]
        no_match['cds_p'] = [cds_p[ind] for ind in no_match_c_ind]

        return (match, no_match, pass_match)
            
def main(parsed_args):
    in_drc_file = parsed_args.in_drc
    in_cds_file = parsed_args.in_cds
    out_file = parsed_args.out_file
    file_type = parsed_args.type

    if not os.path.isfile(in_drc_file):
        print('ERROR: File {0} does not exist.'.format(in_drc_file))
        sys.exit()

    if not os.path.isfile(in_cds_file):
        print('ERROR: File {0} does not exist.'.format(in_cds_file))
        sys.exit()

    in_drc_strm = FileStream(in_drc_file)
    in_cds_strm = FileStream(in_cds_file)

    if file_type == 'calibre' or file_type == 'pvs':
        lexer_drc = drcResultsLexer(in_drc_strm)
        token_stream_drc = CommonTokenStream(lexer_drc)
        parser_drc = drcResultsParser(token_stream_drc)
        printer_drc = DRCErrorListener()

    lexer_cds = cdsResultsLexer(in_cds_strm)
    token_stream_cds = CommonTokenStream(lexer_cds)
    parser_cds = cdsResultsParser(token_stream_cds)
    printer_cds = CDSErrorListener()

    #token_stream_cds.fill()
    #print('tokens:')
    #for i in token_stream_cds.tokens:
    #    print(i)

    #token_stream_drc.fill()
    #print('drc tokens:')
    #for i in token_stream_drc.tokens:
    #    print(i)

    ##tree = parser.header()
    #tree = parser_cds.cds_results()
    #print('tree:')
    #lisp_tree_str = tree.toStringTree(recog=parser_cds)
    #lisp_tree_str = beautify_lisp_string(lisp_tree_str) 
    #print(lisp_tree_str)

    tree_drc = parser_drc.deck_results()

    #print('drc tree:')
    #lisp_tree_str = tree_drc.toStringTree(recog=parser_drc)
    #lisp_tree_str = beautify_lisp_string(lisp_tree_str) 
    #print(lisp_tree_str)

    walker_drc = ParseTreeWalker()
    walker_drc.walk(printer_drc, tree_drc)

    tree_cds = parser_cds.cds_results()
    walker_cds = ParseTreeWalker()
    walker_cds.walk(printer_cds, tree_cds)

    #print(printer_drc.db)
    #print(printer_drc.orig_scale)
    #print(printer_cds.db)
    #print(printer_cds.grid)

    # compare drc and cds results
    error_drc = {}
    error_cds = {}
    error_pass = {}

    #print(sum([len(printer_drc.db[m]['p'])+len(printer_drc.db[m]['e']) for m in printer_drc.db.keys()]))
    total_cds_p = sum([len(printer_cds.db[m]['p']) for m in printer_cds.db.keys()])
    total_cds = total_cds_p
    total_drc_p = sum([len(printer_drc.db[m]['p']) for m in printer_drc.db.keys()])
    total_drc_e = sum([len(printer_drc.db[m]['e']) for m in printer_drc.db.keys()])
    total_drc = total_drc_p + total_drc_e

    drc_rules = sorted(printer_drc.db.keys())
    cds_rules = sorted(printer_cds.db.keys())
    matches = {}
    
    for crule in cds_rules:
        if crule in drc_rules:
            #pop crule from drc_rules
            db_dict = printer_drc.db.pop(crule)

            #check for edge/poly matches
            (match, no_match, pass_match) = find_match(printer_cds.db[crule]['result'], printer_cds.db[crule]['p'], db_dict['p'], db_dict['e'])

            if match['p'] or match['e']:
                matches[crule] = match 
            if no_match['cds_p']:
                error_cds[crule] = {'result': no_match['result'], 'p': no_match['cds_p']}
            if no_match['p'] or no_match['e']:
                error_drc[crule] = {'p': no_match['p'], 'e': no_match['e']}
            if pass_match['p'] or pass_match['e']:
                error_pass[crule] = pass_match 
        else:
            #pop crule from cds_rules
            error_cds[crule] = printer_cds.db.pop(crule)

    # put unmatched drc in error db
    drc_rules = sorted(printer_drc.db.keys())

    for drule in drc_rules:
        error_drc[drule] = printer_drc.db.pop(drule)

    # report drc and cds errors
    #print(error_drc) 
    #print(error_cds) 
    total_match_drc_e = 0 
    total_match_drc_p = 0 
    total_no_match_drc_e = 0 
    total_no_match_drc_p = 0 
    total_no_match_cds_p = 0 
    total_pass_match_drc_e = 0 
    total_pass_match_drc_p = 0 
    with open(out_file, 'w') as fh:
        fh.write('###################\n')
        fh.write('Matched DRC Violations:\n')
        fh.write('###################\n')
        for rule in sorted(matches.keys()):
            total_match_drc_e += len(matches[rule]['e'])
            total_match_drc_p += len(matches[rule]['p'])

            if matches[rule]['e'] or matches[rule]['p']:
                fh.write('    {0}: {1}\n'.format(rule, len(matches[rule]['e'])+len(matches[rule]['p'])))
                for i,e in enumerate(matches[rule]['e']):
                    fh.write('        {0} POLYGON {1}\n'.format(matches[rule]['result_e'][i], ' '.join(str(m) for m in matches[rule]['cds_e'][i].exterior.coords)))
                    fh.write('            ENCLOSES EDGE {0}\n'.format(' '.join(str(m) for m in e.coords)))
                for i,p in enumerate(matches[rule]['p']):
                    fh.write('        {0} POLYGON {1}\n'.format(matches[rule]['result_p'][i], ' '.join(str(m) for m in matches[rule]['cds_p'][i].exterior.coords)))
                    fh.write('            ENCLOSES POLYGON {0}\n'.format(' '.join(str(m) for m in p.exterior.coords)))

        fh.write('\n')
        fh.write('#####################\n')
        fh.write('Unmatched CDS Annotations:\n')
        fh.write('#####################\n')
        for rule in sorted(error_cds.keys()):
            total_no_match_cds_p += len(error_cds[rule]['p'])

            if error_cds[rule]['p']:
                fh.write('    {0}: {1}\n'.format(rule, len(error_cds[rule]['p'])))
                for i,p in enumerate(error_cds[rule]['p']):
                    fh.write('        {0} POLYGON {1}\n'.format(error_cds[rule]['result'][i], ' '.join(str(m) for m in p.exterior.coords)))

        fh.write('\n')
        fh.write('########################\n')
        fh.write('PASS Matched DRC Violations:\n')
        fh.write('########################\n')
        for rule in sorted(error_pass.keys()):
            total_pass_match_drc_e += len(error_pass[rule]['e'])
            total_pass_match_drc_p += len(error_pass[rule]['p'])

            if error_pass[rule]['e'] or error_pass[rule]['p']:
                fh.write('    {0}: {1}\n'.format(rule, len(error_pass[rule]['e'])+len(error_pass[rule]['p'])))
                for i,e in enumerate(error_pass[rule]['e']):
                    fh.write('        {0} POLYGON {1}\n'.format(error_pass[rule]['result_e'][i], ' '.join(str(m) for m in error_pass[rule]['cds_e'][i].exterior.coords)))
                    fh.write('            ENCLOSES EDGE {0}\n'.format(' '.join(str(m) for m in e.coords)))
                for i,p in enumerate(error_pass[rule]['p']):
                    fh.write('        {0} POLYGON {1}\n'.format(error_pass[rule]['result_p'][i], ' '.join(str(m) for m in error_pass[rule]['cds_p'][i].exterior.coords)))
                    fh.write('            ENCLOSES POLYGON {0}\n'.format(' '.join(str(m) for m in p.exterior.coords)))

        fh.write('\n')
        fh.write('#####################\n')
        fh.write('Unmatched DRC Violations:\n')
        fh.write('#####################\n')
        for rule in sorted(error_drc.keys()):
            total_no_match_drc_e += len(error_drc[rule]['e'])
            total_no_match_drc_p += len(error_drc[rule]['p'])

            if error_drc[rule]['e'] or error_drc[rule]['p']:
                fh.write('    {0}: {1}\n'.format(rule, len(error_drc[rule]['e'])+len(error_drc[rule]['p'])))
                for e in error_drc[rule]['e']:
                    fh.write('        EDGE {0}\n'.format(' '.join(str(m) for m in e.coords)))
                for p in error_drc[rule]['p']:
                    fh.write('        POLYGON {0}\n'.format(' '.join(str(m) for m in p.exterior.coords)))

        total_match_drc = total_match_drc_e + total_match_drc_p 
        total_no_match_drc = total_no_match_drc_e + total_no_match_drc_p 
        total_no_match_cds = total_no_match_cds_p 
        total_pass_match_drc = total_pass_match_drc_e + total_pass_match_drc_p 
        total_error = total_no_match_drc + total_no_match_cds + total_pass_match_drc

        fh.write('\n')
        fh.write('########\n')
        fh.write('Summary:\n')
        fh.write('########\n')
        fh.write('\n')
        fh.write('Total CDS Annotations: {0}\n'.format(total_cds))
        fh.write('    POLYGON: {0}\n'.format(total_cds_p))
        fh.write('Total DRC Violations: {0}\n'.format(total_drc))
        fh.write('    EDGE: {0}\n'.format(total_drc_e))
        fh.write('    POLYGON: {0}\n'.format(total_drc_p))
        fh.write('\n')
        fh.write('Matched DRC Violations: {0}\n'.format(total_match_drc))
        fh.write('    EDGE: {0}\n'.format(total_match_drc_e))
        fh.write('    POLYGON: {0}\n'.format(total_match_drc_p))
        fh.write('\n')
        fh.write('Unmatched CDS Annotations: {0}\n'.format(total_no_match_cds))
        fh.write('    POLYGON: {0}\n'.format(total_no_match_cds_p))
        fh.write('PASS Matched DRC Violations: {0}\n'.format(total_pass_match_drc))
        fh.write('    EDGE: {0}\n'.format(total_pass_match_drc_e))
        fh.write('    POLYGON: {0}\n'.format(total_pass_match_drc_p))
        fh.write('Unmatched DRC Violations: {0}\n'.format(total_no_match_drc))
        fh.write('    EDGE: {0}\n'.format(total_no_match_drc_e))
        fh.write('    POLYGON: {0}\n'.format(total_no_match_drc_p))
        fh.write('\n')
        fh.write('Total Errors: {0}\n'.format(total_error))
        fh.write('\n')
        fh.write('{0}:{1}:{2}:{3}:{4}:{5}\n'.format(total_no_match_cds, total_pass_match_drc, total_no_match_drc, total_match_drc, total_cds, total_drc))

if __name__ == '__main__':
    (parsed_args, unparsed_args) = process_args()

    if unparsed_args:
        print('ERROR: {0}'.format(unparsed_args))
    else:
        main(parsed_args) 
