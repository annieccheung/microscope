palindrome: (string) ->
  if string.split("") == string.split("").reverse
    "true"
  else
    "false"