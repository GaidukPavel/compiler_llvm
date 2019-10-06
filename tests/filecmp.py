import difflib
text1 = open("Lexer_out").readlines()
text2 = open("out_expected").readlines()

for line in difflib.unified_diff(text1, text2):
    print line,