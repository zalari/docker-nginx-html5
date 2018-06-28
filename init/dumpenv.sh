PREFIX=$1_
OUTPUTFILE=$2
jq -n env | jq --arg prefix $PREFIX 'to_entries | map(select(.key | match($prefix;"g"))) | from_entries | with_entries(.key |= sub($prefix; ""))' | cat > temp.json
jq -s 'add' config.default.json temp.json | cat > $OUTPUTFILE
rm temp.json
