alias 1p-login='eval $(op signin my)'

function 1p() {
  passwd=$(op get item $1 | jq '.details.fields[] | select(.designation=="password").value')

  if test -z "$passwd"
  then
    false
  else
    # remove surronding "
    passwd=${passwd#"\""}
    passwd=${passwd%"\""}
    echo "${passwd}" | xclip -se clip
  fi
}