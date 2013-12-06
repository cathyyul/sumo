SENARIO=test-100
TRIPTIME=100
PERIOD=1
ROUTETIME=800
GRIDNUM=5
SUMOPATH=$HOME/sumo
NAME=grid

python $SUMOPATH/tools/trip/randomTrips.py -n $NAME.net.xml -e $TRIPTIME -p $PERIOD -o $NAME.trip.xml

$SUMOPATH/bin/duarouter -t $NAME.trip.xml -n $NAME.net.xml -e $ROUTETIME -o $NAME.rou.xml

$SUMOPATH/bin/sumo -c $NAME.sumocfg --fcd-output $SCENARIO.fcd.xml

sh $SUMOPATH/tools/bin/fcd-qualnet.sh $SUMOPATH $SCENARIO.fcd.xml $SCENARIO.mob

sh sumo-corner.sh $GRIDNUM $NAME.nod.xml $NAME.edg.xml $NAME.nodes $NAME.links
