SENARIO=test-100
TRIPTIME=100
PERIOD=1
ROUTETIME=800
GRIDNUM=5
SUMOPATH=/home/mars/sumo
NAME=test

python $SUMOPATH/tools/trip/randomTrips.py -n $NAME.net.xml -e $TRIPTIME -p $PERIOD -o $NAME.trip.xml

duarouter -t $NAME.trip.xml -n $NAME.net.xml -e $ROUTETIME -o $NAME.rou.xml

sumo -c $NAME.sumocfg --fcd-output $SCENARIO.fcd.xml

sh fcd-qualnet.sh $SUMOPATH $SCENARIO.fcd.xml $SCENARIO.mob

sh sumo-corner.sh $GRIDNUM $NAME.nod.xml $NAME.edg.xml $NAME.nodes $NAME.links
