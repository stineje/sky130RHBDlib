# Generated from cdsResults.g4 by ANTLR 4.7.2
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys



def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\f")
        buf.write("Z\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write("\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t\13\3\2\3\2\3\3\3\3\3\4")
        buf.write("\3\4\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3")
        buf.write("\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\7\b\66")
        buf.write("\n\b\f\b\16\b9\13\b\3\t\5\t<\n\t\3\t\6\t?\n\t\r\t\16\t")
        buf.write("@\3\t\3\t\6\tE\n\t\r\t\16\tF\5\tI\n\t\3\n\6\nL\n\n\r\n")
        buf.write("\16\nM\3\n\3\n\3\13\5\13S\n\13\3\13\3\13\6\13W\n\13\r")
        buf.write("\13\16\13X\2\2\f\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23")
        buf.write("\13\25\f\3\2\6\4\2C\\c|\6\2\13\f\17\17\"\"$$\3\2\62;\4")
        buf.write("\2\13\13\"\"\2b\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2")
        buf.write("\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21")
        buf.write("\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\3\27\3\2\2\2\5\31\3")
        buf.write("\2\2\2\7\33\3\2\2\2\t\35\3\2\2\2\13\"\3\2\2\2\r\'\3\2")
        buf.write("\2\2\17\63\3\2\2\2\21;\3\2\2\2\23K\3\2\2\2\25V\3\2\2\2")
        buf.write("\27\30\7$\2\2\30\4\3\2\2\2\31\32\7*\2\2\32\6\3\2\2\2\33")
        buf.write("\34\7+\2\2\34\b\3\2\2\2\35\36\7R\2\2\36\37\7C\2\2\37 ")
        buf.write("\7U\2\2 !\7U\2\2!\n\3\2\2\2\"#\7H\2\2#$\7C\2\2$%\7K\2")
        buf.write("\2%&\7N\2\2&\f\3\2\2\2\'(\7a\2\2()\7T\2\2)*\7G\2\2*+\7")
        buf.write("U\2\2+,\7Q\2\2,-\7N\2\2-.\7W\2\2./\7V\2\2/\60\7K\2\2\60")
        buf.write("\61\7Q\2\2\61\62\7P\2\2\62\16\3\2\2\2\63\67\t\2\2\2\64")
        buf.write("\66\n\3\2\2\65\64\3\2\2\2\669\3\2\2\2\67\65\3\2\2\2\67")
        buf.write("8\3\2\2\28\20\3\2\2\29\67\3\2\2\2:<\7/\2\2;:\3\2\2\2;")
        buf.write("<\3\2\2\2<>\3\2\2\2=?\t\4\2\2>=\3\2\2\2?@\3\2\2\2@>\3")
        buf.write("\2\2\2@A\3\2\2\2AH\3\2\2\2BD\7\60\2\2CE\t\4\2\2DC\3\2")
        buf.write("\2\2EF\3\2\2\2FD\3\2\2\2FG\3\2\2\2GI\3\2\2\2HB\3\2\2\2")
        buf.write("HI\3\2\2\2I\22\3\2\2\2JL\t\5\2\2KJ\3\2\2\2LM\3\2\2\2M")
        buf.write("K\3\2\2\2MN\3\2\2\2NO\3\2\2\2OP\b\n\2\2P\24\3\2\2\2QS")
        buf.write("\7\17\2\2RQ\3\2\2\2RS\3\2\2\2ST\3\2\2\2TW\7\f\2\2UW\7")
        buf.write("\17\2\2VR\3\2\2\2VU\3\2\2\2WX\3\2\2\2XV\3\2\2\2XY\3\2")
        buf.write("\2\2Y\26\3\2\2\2\f\2\67;@FHMRVX\3\b\2\2")
        return buf.getvalue()


class cdsResultsLexer(Lexer):

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    T__0 = 1
    T__1 = 2
    T__2 = 3
    T__3 = 4
    T__4 = 5
    T__5 = 6
    RULENAME = 7
    NUMBER = 8
    WS = 9
    NL = 10

    channelNames = [ u"DEFAULT_TOKEN_CHANNEL", u"HIDDEN" ]

    modeNames = [ "DEFAULT_MODE" ]

    literalNames = [ "<INVALID>",
            "'\"'", "'('", "')'", "'PASS'", "'FAIL'", "'_RESOLUTION'" ]

    symbolicNames = [ "<INVALID>",
            "RULENAME", "NUMBER", "WS", "NL" ]

    ruleNames = [ "T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "RULENAME", 
                  "NUMBER", "WS", "NL" ]

    grammarFileName = "cdsResults.g4"

    def __init__(self, input=None, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


