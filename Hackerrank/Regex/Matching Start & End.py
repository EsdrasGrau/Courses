import re
Regex_Pattern = r"^\d.....$"  # Do not delete 'r'.


print(str(bool(re.search(Regex_Pattern, input()))).lower())
