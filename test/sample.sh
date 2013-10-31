SCENARIO=test-25
TRIPTIME=25
PERIOD=1
ROUTETIME=800
SUMOPATH=/home/mars/sumo
NAME=test

python $SUMOPATH/tools/trip/randomTrips.py -n $NAME.net.xml -e $TRIPTIME -p $PERIOD -o $NAME.trip.xml

duarouter -t $NAME.trip.xml -n $NAME.net.xml -e $ROUTETIME -o $NAME.rou.xml

sumo -c $NAME.sumocfg --fcd-output $SCENARIO.fcd.xml
