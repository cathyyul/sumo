GRIDNO=$1
NODEFILE=$2
EDGEFILE=$3
NODESOUTPUT=$4
LINKSOUTPUT=$5

#GRIDNO=5
#NODEFILE='./800-test/test.nod.xml'
#EDGEFILE='./800-test/test.edg.xml'

cp $NODEFILE vmfnode.xml
cp $EDGEFILE vmfedge.xml

for i in $(seq 0 $(($GRIDNO-1)))
do
  for j in $(seq 0 $(($GRIDNO-1)))
    do
      old=$i/$j
      #echo "old $old"
      new=$(($i*$GRIDNO+$j+1))
      #echo "new $new"
      sed -i -e  "s|$old|$new|g" vmfnode.xml
      sed -i -e  "s|$old|$new|g" vmfedge.xml
      sed -i 's/\([0-9][0-9]*\)to/\1/g' vmfedge.xml
      #sed -i  "s|$old|$new|g" vmfoutput.xml
      #sed -i 's/\([0-9][0-9]*\)to/\1/g' vmfoutput.xml
    done
done

grep 'node id' vmfnode.xml > temp
awk -F" " '{print $2 "  " $3 "  " $4}' temp > tempo
mv tempo temp
sed -e 's/id=//g' -e 's/x=//g' -e 's/y=//g' -e 's/\"//g' temp > tempo
mv tempo temp
awk -F" " '{printf "%-8s %-8s %-8s\n", $1, $2, $3}' temp > tempo
grep -c . tempo > $4
cat tempo >> $4
rm tempo
rm temp

grep 'edge id' vmfedge.xml > temp
awk -F" " '{print $3 " " $4 " " $6 " " "False 0 " $7}' temp > tempo
mv tempo temp
sed -e 's/from=//g' \
    -e 's/to=//g' \
    -e 's/numLanes=//' \
    -e 's/speed=//g' \
    -e 's/\"//g' \
    -e 's|/>||g' temp > tempo
mv tempo temp
awk -F" " '{printf "%-6s %-6s %-6s %-6s %-6s %-6s\n", $1, $2, $3, $4, $5, $6}' temp > tempo
grep -c . tempo > $5
cat tempo >> $5
rm tempo
rm temp


