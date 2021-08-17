import re

#Check if the string contains "ai"

txt = "The rain in Spain"

x = re.search("(\s)(\w*)(ai)(\w*)(\s)", txt)

if x:
    print(x.group(1))
    print("YES! We have a match!")
else:
    print("No match")



