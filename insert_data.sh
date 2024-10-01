#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
i=1 n=0
while IFS=',' read -r year round winner opponent winner_goals opponent_goals
do
 if (( n >= i ))
  then
    
#    echo "Year: $year, Round: $round, Winner: $winner, Opponent: $opponent, Winner Goals: $winner_goals, Opponent Goals: $opponent_goals"

CHECKED_WINNER=$($PSQL "SELECT name FROM teams WHERE name = '$WINNER'")
if [[ -z $CHECKED_WINNER ]]
then
INSERTED=$($PSQL "INSERT INTO teams(name) VALUES('$winner');") 
echo $INSERTED
fi
CHECKED_OPPONENT=$($PSQL "SELECT name FROM teams WHERE name = '$opponent'")
if [[ -z $CHECKED_OPPONENT ]]
then
INSERTED1=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
echo $INSERTED1 
fi
 
$PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
 VALUES (
    $year, 
    '$round', 
    (SELECT team_id FROM teams WHERE name = '$winner'), 
    (SELECT team_id FROM teams WHERE name = '$opponent'), 
    $winner_goals, 
    $opponent_goals
);"

fi
((n++))
done < games.csv