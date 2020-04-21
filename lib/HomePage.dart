import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  static List<int> snakePosition = [45,65,85,105,125];
  int numberOfSquares = 760;
  int food = Random().nextInt(700);
  void generateNewFood(){
    food = Random().nextInt(700);
  }
  void startGame() 
  {
    snakePosition = [45,65,85,105,125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer ) {
      updateSnake();
      if(gameOver()){
        timer.cancel();
        _showGameOverScreen();
      }
    }
    );
  }
  var   direction = 'down';
  void updateSnake(){
     setState(() {
        switch (direction) {
        case 'down':
              if (snakePosition.last > 740)
                snakePosition.add(snakePosition.last+20 - 760);
             else 
                snakePosition.add(snakePosition.last+20);
                break;
         case 'up':
              if(snakePosition.last < 20)
                    snakePosition.add(snakePosition.last - 20 + 760);
              else 
                  snakePosition.add(snakePosition.last - 20 - 760);
              break;
        case 'left':
              if (snakePosition.last % 20 == 0)
                  snakePosition.add(snakePosition.last -1 + 20);
              else 
                  snakePosition.add(snakePosition.last -1);
             break;
        case 'right':
              if ((snakePosition.last +1)  % 20 == 0)
                  snakePosition.add(snakePosition.last + 1 - 20);
              else 
                  snakePosition.add(snakePosition.last + 1);     
                break;
          default: 
        }
        if ( snakePosition.last == food)
            generateNewFood();
            else 
            snakePosition.removeAt(0);

     });
  }
  bool gameOver(){
    for ( int i = 0 ;  i < snakePosition.length; i++){
      int count = 0;
      for ( int j=0 ; j < snakePosition.length; j++ ){
        if(snakePosition[i] == snakePosition[j])
        {
          count = count +1;

        }
        if(count == 2)
           return true;
        }
      }
       return false;
    }
    void _showGameOverScreen() {
      showDialog(context: context, 
         builder: (BuildContext context){
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('Score: '+ snakePosition.length.toString()),
              actions: <Widget>[
                RaisedButton(
                  child: Text('Play Again'),
                  onPressed: () {
                      startGame();
                      Navigator.of(context).pop();
                  }
                  ),
              ],
            );
         }
      );
    }
   @override
   Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       body: Column(
         children: <Widget>[
           Expanded(
             child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if(direction != 'up' && details.delta.dy>0)
                     direction = 'down';
                  else if(direction != 'down' && details.delta.dy < 0)
                      direction = 'up';
                },
                onHorizontalDragUpdate: (details){
                  if(direction != 'left' && details.delta.dx > 0)
                         direction = 'right';
                  else if(direction != 'right' && details.delta.dx < 0)
                          direction = 'left';
                },
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20
                      ), 
                      itemCount: numberOfSquares,
                       itemBuilder: (BuildContext context, int index) {
                         if (snakePosition.contains(index)){
                           return Center(
                         child: Container(
                           padding:EdgeInsets.all(2),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(5),
                             child: Container(
                               color: Colors.black,
                             ),
                           ),
                         ),
                      );
                      }
                      if (index == food ){
                         return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container( color:  Colors.red,),
                          ),
                      );
                    }
                    else {
                      return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(color:Colors.white),
                            ),
                      );
                    }
                    }
                    ),
                ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(bottom:20.0, left : 20.0 ,right : 20.0),
             child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   GestureDetector(
                     onTap: startGame,
                     child: Text("Start",style: TextStyle(color: Colors.blue),),
                   )
                ],
             ),
           )
         ],
       ),
    );
  }
} 