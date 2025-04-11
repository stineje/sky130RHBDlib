# Generated from cdsResults.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\f")
        buf.write("]\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b")
        buf.write("\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\4\16\t")
        buf.write("\16\3\2\7\2\36\n\2\f\2\16\2!\13\2\3\2\3\2\3\3\3\3\3\3")
        buf.write("\3\3\3\3\3\3\3\3\3\3\5\3-\n\3\3\3\3\3\3\4\3\4\3\4\3\4")
        buf.write("\3\5\3\5\6\5\67\n\5\r\5\16\58\3\5\3\5\3\6\3\6\3\6\3\6")
        buf.write("\3\6\3\6\3\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3")
        buf.write("\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3")
        buf.write("\16\3\16\3\16\2\2\17\2\4\6\b\n\f\16\20\22\24\26\30\32")
        buf.write("\2\3\3\2\6\7\2R\2\37\3\2\2\2\4,\3\2\2\2\6\60\3\2\2\2\b")
        buf.write("\64\3\2\2\2\n<\3\2\2\2\fC\3\2\2\2\16N\3\2\2\2\20P\3\2")
        buf.write("\2\2\22R\3\2\2\2\24T\3\2\2\2\26V\3\2\2\2\30X\3\2\2\2\32")
        buf.write("Z\3\2\2\2\34\36\5\4\3\2\35\34\3\2\2\2\36!\3\2\2\2\37\35")
        buf.write("\3\2\2\2\37 \3\2\2\2 \"\3\2\2\2!\37\3\2\2\2\"#\7\2\2\3")
        buf.write("#\3\3\2\2\2$%\5\6\4\2%&\5\b\5\2&-\3\2\2\2\'(\7\3\2\2(")
        buf.write(")\5\30\r\2)*\7\3\2\2*+\5\32\16\2+-\3\2\2\2,$\3\2\2\2,")
        buf.write("\'\3\2\2\2-.\3\2\2\2./\7\f\2\2/\5\3\2\2\2\60\61\7\3\2")
        buf.write("\2\61\62\7\t\2\2\62\63\7\3\2\2\63\7\3\2\2\2\64\66\7\4")
        buf.write("\2\2\65\67\5\n\6\2\66\65\3\2\2\2\678\3\2\2\28\66\3\2\2")
        buf.write("\289\3\2\2\29:\3\2\2\2:;\7\5\2\2;\t\3\2\2\2<=\7\4\2\2")
        buf.write("=>\5\f\7\2>?\7\3\2\2?@\5\26\f\2@A\7\3\2\2AB\7\5\2\2B\13")
        buf.write("\3\2\2\2CD\7\4\2\2DE\7\4\2\2EF\5\16\b\2FG\5\20\t\2GH\7")
        buf.write("\5\2\2HI\7\4\2\2IJ\5\22\n\2JK\5\24\13\2KL\7\5\2\2LM\7")
        buf.write("\5\2\2M\r\3\2\2\2NO\7\n\2\2O\17\3\2\2\2PQ\7\n\2\2Q\21")
        buf.write("\3\2\2\2RS\7\n\2\2S\23\3\2\2\2TU\7\n\2\2U\25\3\2\2\2V")
        buf.write("W\t\2\2\2W\27\3\2\2\2XY\7\b\2\2Y\31\3\2\2\2Z[\7\n\2\2")
        buf.write("[\33\3\2\2\2\5\37,8")
        return buf.getvalue()


class cdsResultsParser ( Parser ):

    grammarFileName = "cdsResults.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'\"'", "'('", "')'", "'PASS'", "'FAIL'", 
                     "'_RESOLUTION'" ]

    symbolicNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "RULENAME", 
                      "NUMBER", "WS", "NL" ]

    RULE_cds_results = 0
    RULE_rule_res = 1
    RULE_rulename = 2
    RULE_annotate_res = 3
    RULE_annotate = 4
    RULE_bbox = 5
    RULE_lx = 6
    RULE_ly = 7
    RULE_ux = 8
    RULE_uy = 9
    RULE_result = 10
    RULE_resolution = 11
    RULE_grid = 12

    ruleNames =  [ "cds_results", "rule_res", "rulename", "annotate_res", 
                   "annotate", "bbox", "lx", "ly", "ux", "uy", "result", 
                   "resolution", "grid" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    RULENAME=7
    NUMBER=8
    WS=9
    NL=10

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class Cds_resultsContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def EOF(self):
            return self.getToken(cdsResultsParser.EOF, 0)

        def rule_res(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(cdsResultsParser.Rule_resContext)
            else:
                return self.getTypedRuleContext(cdsResultsParser.Rule_resContext,i)


        def getRuleIndex(self):
            return cdsResultsParser.RULE_cds_results

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCds_results" ):
                listener.enterCds_results(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCds_results" ):
                listener.exitCds_results(self)




    def cds_results(self):

        localctx = cdsResultsParser.Cds_resultsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_cds_results)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 29
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==cdsResultsParser.T__0:
                self.state = 26
                self.rule_res()
                self.state = 31
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 32
            self.match(cdsResultsParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Rule_resContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NL(self):
            return self.getToken(cdsResultsParser.NL, 0)

        def rulename(self):
            return self.getTypedRuleContext(cdsResultsParser.RulenameContext,0)


        def annotate_res(self):
            return self.getTypedRuleContext(cdsResultsParser.Annotate_resContext,0)


        def resolution(self):
            return self.getTypedRuleContext(cdsResultsParser.ResolutionContext,0)


        def grid(self):
            return self.getTypedRuleContext(cdsResultsParser.GridContext,0)


        def getRuleIndex(self):
            return cdsResultsParser.RULE_rule_res

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRule_res" ):
                listener.enterRule_res(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRule_res" ):
                listener.exitRule_res(self)




    def rule_res(self):

        localctx = cdsResultsParser.Rule_resContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_rule_res)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 42
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,1,self._ctx)
            if la_ == 1:
                self.state = 34
                self.rulename()
                self.state = 35
                self.annotate_res()
                pass

            elif la_ == 2:
                self.state = 37
                self.match(cdsResultsParser.T__0)
                self.state = 38
                self.resolution()
                self.state = 39
                self.match(cdsResultsParser.T__0)
                self.state = 40
                self.grid()
                pass


            self.state = 44
            self.match(cdsResultsParser.NL)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class RulenameContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def RULENAME(self):
            return self.getToken(cdsResultsParser.RULENAME, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_rulename

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRulename" ):
                listener.enterRulename(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRulename" ):
                listener.exitRulename(self)




    def rulename(self):

        localctx = cdsResultsParser.RulenameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_rulename)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 46
            self.match(cdsResultsParser.T__0)
            self.state = 47
            self.match(cdsResultsParser.RULENAME)
            self.state = 48
            self.match(cdsResultsParser.T__0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Annotate_resContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def annotate(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(cdsResultsParser.AnnotateContext)
            else:
                return self.getTypedRuleContext(cdsResultsParser.AnnotateContext,i)


        def getRuleIndex(self):
            return cdsResultsParser.RULE_annotate_res

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAnnotate_res" ):
                listener.enterAnnotate_res(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAnnotate_res" ):
                listener.exitAnnotate_res(self)




    def annotate_res(self):

        localctx = cdsResultsParser.Annotate_resContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_annotate_res)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 50
            self.match(cdsResultsParser.T__1)
            self.state = 52 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 51
                self.annotate()
                self.state = 54 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==cdsResultsParser.T__1):
                    break

            self.state = 56
            self.match(cdsResultsParser.T__2)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class AnnotateContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def bbox(self):
            return self.getTypedRuleContext(cdsResultsParser.BboxContext,0)


        def result(self):
            return self.getTypedRuleContext(cdsResultsParser.ResultContext,0)


        def getRuleIndex(self):
            return cdsResultsParser.RULE_annotate

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAnnotate" ):
                listener.enterAnnotate(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAnnotate" ):
                listener.exitAnnotate(self)




    def annotate(self):

        localctx = cdsResultsParser.AnnotateContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_annotate)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 58
            self.match(cdsResultsParser.T__1)
            self.state = 59
            self.bbox()
            self.state = 60
            self.match(cdsResultsParser.T__0)
            self.state = 61
            self.result()
            self.state = 62
            self.match(cdsResultsParser.T__0)
            self.state = 63
            self.match(cdsResultsParser.T__2)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class BboxContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def lx(self):
            return self.getTypedRuleContext(cdsResultsParser.LxContext,0)


        def ly(self):
            return self.getTypedRuleContext(cdsResultsParser.LyContext,0)


        def ux(self):
            return self.getTypedRuleContext(cdsResultsParser.UxContext,0)


        def uy(self):
            return self.getTypedRuleContext(cdsResultsParser.UyContext,0)


        def getRuleIndex(self):
            return cdsResultsParser.RULE_bbox

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBbox" ):
                listener.enterBbox(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBbox" ):
                listener.exitBbox(self)




    def bbox(self):

        localctx = cdsResultsParser.BboxContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_bbox)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 65
            self.match(cdsResultsParser.T__1)
            self.state = 66
            self.match(cdsResultsParser.T__1)
            self.state = 67
            self.lx()
            self.state = 68
            self.ly()
            self.state = 69
            self.match(cdsResultsParser.T__2)
            self.state = 70
            self.match(cdsResultsParser.T__1)
            self.state = 71
            self.ux()
            self.state = 72
            self.uy()
            self.state = 73
            self.match(cdsResultsParser.T__2)
            self.state = 74
            self.match(cdsResultsParser.T__2)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class LxContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NUMBER(self):
            return self.getToken(cdsResultsParser.NUMBER, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_lx

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLx" ):
                listener.enterLx(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLx" ):
                listener.exitLx(self)




    def lx(self):

        localctx = cdsResultsParser.LxContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_lx)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 76
            self.match(cdsResultsParser.NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class LyContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NUMBER(self):
            return self.getToken(cdsResultsParser.NUMBER, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_ly

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLy" ):
                listener.enterLy(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLy" ):
                listener.exitLy(self)




    def ly(self):

        localctx = cdsResultsParser.LyContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_ly)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 78
            self.match(cdsResultsParser.NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class UxContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NUMBER(self):
            return self.getToken(cdsResultsParser.NUMBER, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_ux

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUx" ):
                listener.enterUx(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUx" ):
                listener.exitUx(self)




    def ux(self):

        localctx = cdsResultsParser.UxContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_ux)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 80
            self.match(cdsResultsParser.NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class UyContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NUMBER(self):
            return self.getToken(cdsResultsParser.NUMBER, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_uy

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUy" ):
                listener.enterUy(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUy" ):
                listener.exitUy(self)




    def uy(self):

        localctx = cdsResultsParser.UyContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_uy)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 82
            self.match(cdsResultsParser.NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ResultContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return cdsResultsParser.RULE_result

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterResult" ):
                listener.enterResult(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitResult" ):
                listener.exitResult(self)




    def result(self):

        localctx = cdsResultsParser.ResultContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_result)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 84
            _la = self._input.LA(1)
            if not(_la==cdsResultsParser.T__3 or _la==cdsResultsParser.T__4):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ResolutionContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return cdsResultsParser.RULE_resolution

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterResolution" ):
                listener.enterResolution(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitResolution" ):
                listener.exitResolution(self)




    def resolution(self):

        localctx = cdsResultsParser.ResolutionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_resolution)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 86
            self.match(cdsResultsParser.T__5)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class GridContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def NUMBER(self):
            return self.getToken(cdsResultsParser.NUMBER, 0)

        def getRuleIndex(self):
            return cdsResultsParser.RULE_grid

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterGrid" ):
                listener.enterGrid(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitGrid" ):
                listener.exitGrid(self)




    def grid(self):

        localctx = cdsResultsParser.GridContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_grid)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 88
            self.match(cdsResultsParser.NUMBER)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





