alias 1p-login='eval $(op signin my)'

function 1p() {
    passwd=$(op get item $1 | jq '.details.fields[] | select(.designation=="password").value')
    # | xclip && echo "password copied"
if test -z "$passwd"
then
      echo ""
else
      echo "$passwd" | xclip -se clip
      echo "Password copied"
fi

}