import 'package:flutter/material.dart';
import 'package:minesweeper_4/bomb.dart';
import 'package:minesweeper_4/numberBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables
  int numberOfSquares = 9 *9;
  int numberinEachRow = 9;

  // [num of bombs around, revealed boolean]
  var squareStatus = []; 

  //initial squareStatus
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //each square has 0 bombs around as it is unrevealed

    for (int i=0; i <numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }

    scanBombs();
  }

    //bomb location:
    final List<int> bombLocation = [];

    bool bombsRevealed = false;

    //reveal 
    void revealBoxNumbers(int index) {

      //reveal current box if num = 1, 2, 3+
      if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
        });
      }

      //if square = 0 bombs...
      else if (squareStatus[index][0] ==0) {
        //reveal current box + surrounding (- walls)
        setState(() {
          squareStatus[index][1] = true;

          //left box check 
          if (index % numberinEachRow !=0) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index-1][0] == 0 && squareStatus[index-1][1] == false) {
              revealBoxNumbers(index-1);
            }

            //reveal left box
            squareStatus[index-1][1]=true;
          }

          //top left - top row/left wall

          if (index % numberinEachRow !=0 && index <= numberinEachRow) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index-1 -numberinEachRow][0] == 0 
                && squareStatus[index-1 - numberinEachRow][1] == false) {
              revealBoxNumbers(index-1 -numberinEachRow);
            }

            //reveal top left box
            squareStatus[index-1 -numberinEachRow][1]=true;
          }


          //top box - top row
          if (index >= numberinEachRow) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index -numberinEachRow][0] == 0 
                && squareStatus[index- numberinEachRow][1] == false) {
              revealBoxNumbers(index -numberinEachRow);
            }

            //reveal top box
            squareStatus[index -numberinEachRow][1]=true;
          }

          //top right box - right/top row
          if (index >= numberinEachRow &&
            index % numberinEachRow != numberinEachRow -1) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index +1  -numberinEachRow][0] == 0 
                && squareStatus[index +1 - numberinEachRow][1] == false) {
              revealBoxNumbers(index +1 -numberinEachRow);
            }

            //reveal top right box
            squareStatus[index +1 -numberinEachRow][1]=true;
          }


          //right box - right row
          if (index % numberinEachRow != numberinEachRow -1) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index +1][0] == 0 
                && squareStatus[index +1][1] == false) {
              revealBoxNumbers(index +1);
            }

            //reveal right box
            squareStatus[index +1][1]=true;
          }

          //bottom right box - bottom/right 
          if (index < numberOfSquares - numberinEachRow
            && index % numberinEachRow != numberinEachRow -1) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index +1 +numberinEachRow][0] == 0 
                && squareStatus[index +1 + numberinEachRow][1] == false) {
              revealBoxNumbers(index +1 + numberinEachRow);
            }

            //reveal right box
            squareStatus[index +1 + numberinEachRow][1]=true;
          }    

          //bottom box
          if (index < numberOfSquares - numberinEachRow) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index + numberinEachRow][0] == 0 
                && squareStatus[index + numberinEachRow][1] == false) {
              revealBoxNumbers(index + numberinEachRow);
            }

            //reveal bottom box
            squareStatus[index + numberinEachRow][1]=true;
          }          

          //bottom left box
          if (index < numberOfSquares - numberinEachRow
            && index % numberinEachRow != 0) {
            //if next box not revealed + also 0, recurse
            if (squareStatus[index -1 + numberinEachRow][0] == 0 
                && squareStatus[index -1 + numberinEachRow][1] == false) {
              revealBoxNumbers(index -1 + numberinEachRow);
            }

            //reveal bottom left box
            squareStatus[index -1 + numberinEachRow][1]=true;
          }     

        });
      }
    }

    void scanBombs() {
      for (int i =0; i < numberOfSquares; i++) {
        int numberBombsAround =0;

        //check 8 surrounding boxes around square to look for bombs

        //left (except column 0)
        if (bombLocation.contains(i-1) && i % numberinEachRow != 0) {
          numberBombsAround++;
        }

        //top left (-first column/row)
        if (bombLocation.contains(i-1) && i % numberinEachRow !=0 && i>=numberinEachRow) {
          numberBombsAround++;
        }

        //top (-first row)
        if (bombLocation.contains(i- numberinEachRow) && i >= numberinEachRow) {
          numberBombsAround++;
        }

        //top right
        if (bombLocation.contains(i + 1 -numberinEachRow) && i >= numberinEachRow && i % numberinEachRow != numberinEachRow-1) {
          numberBombsAround++;
        }
        
        //right 

        if (bombLocation.contains(i+1) && i % numberinEachRow != numberinEachRow-1) {
          numberBombsAround++;
        }

        //bottom right
        if (bombLocation.contains(i + 1 + numberinEachRow) && i % numberinEachRow != numberinEachRow-1 && i < numberOfSquares -numberinEachRow) {
          numberBombsAround++;
        }

        //bottom
        if (bombLocation.contains(i+ numberinEachRow) && i < numberOfSquares-numberinEachRow) {
          numberBombsAround++;
        }
        //bottom left

        if (bombLocation.contains(i - 1 +numberinEachRow) && i < numberOfSquares - numberinEachRow && i % numberinEachRow != 0) {
          numberBombsAround++;
        }

        //add total number of bombs around to square status
        setState(() {
          squareStatus[i][0] = numberBombsAround;
        });
  
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          //game stats/menu
          Container(
            height: 150,
            //color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //bomb counter
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("6", style: TextStyle(fontSize: 48),),
                    Text("B O M B S")
                  ],
                ),

                //refresh game
                Card(
                  color: Colors.grey[700],
                  child: Icon(Icons.refresh, color: Colors.white,
                  size:48,)
                ),


                //timer
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("6", style: TextStyle(fontSize: 48),),
                    Text("B O M B S")
                  ],
                )
              ],
            ),
          ),

          //grid
          Expanded(
            child: GridView.builder(
              itemCount: numberOfSquares,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: 
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberinEachRow),
              itemBuilder: (context, index) {
                if (bombLocation.contains(index)) {
                  return MyBomb(bombsRevealed,
                  () {
                    setState(() {
                      bombsRevealed = true;
                    });
                    //user taps the box, loses
                  } );
                } else {
                  return MyNumberBox(squareStatus[index][0], squareStatus[index][1], (){
                    //reveal 
                    revealBoxNumbers(index);
                  });
                }
              } ),
          ),

          //branding
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text("Made by Val"),
          )
        ],
      )
    );
  }
}