import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'colors.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  double num1=0.0;
  double num2=0.0;
  var input="";
  var output="";
  var operator="";
  var result=false;
  var size=35.0;
  List<String> historyofCalculation=[ ];

  onclick(value){
    
    if(value=="="){
      if(input.isNotEmpty){
      var userinput=input;
      userinput=input.replaceAll("×", "*");
      Parser parser=Parser();
      Expression expression=parser.parse(userinput);
      ContextModel con=ContextModel();
      var finaloutput=expression.evaluate(EvaluationType.REAL, con);
      output=finaloutput.toString();
      if(output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input=output;
      result=true;
      size=48;
      historyofCalculation.add(userinput + "=" + output);
      }
    }
    else
      {
        result=false;
        size=38;
        input=input+value;
      }
    setState(() {

    });
  }

  void historybox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Calculation History'),
          content: Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:historyofCalculation.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: ListTile(
                    title: Text(historyofCalculation[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,color: Colors.black,),
                      onPressed: (){
                        setState(() {
                         historyofCalculation.removeAt(index);
                        });
                        Navigator.pop(context);
                        historybox(context) ;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(22),
                color: Colors.black38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                     Text(result ? " ":input,style: TextStyle(
                       fontSize: 48,
                       color: Colors.white.withOpacity(0.7),
                       fontWeight: FontWeight.w400
                     ),),
                   SizedBox(height: 8,),
                   Text(output,style: TextStyle(
                       fontSize: size,
                       color: Colors.white.withOpacity(0.5),
                       fontWeight: FontWeight.w200
                   ),)
                 ],
                ),
              )
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      input="";
                      output="";
                    });

                  },
                  icon: Icon(Icons.refresh,color: Colors.grey,size: 32,)
              ),
              IconButton(
                    onPressed: (){
                      historybox(context);
                    },
                    icon: Icon(Icons.history,color: Colors.grey,size: 32,)
                ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0),
                child: IconButton(
                    onPressed: (){
                      setState(() {
                        if (input.isNotEmpty){
                          input=input.substring(0,input.length-1);
                          output="";
                        }
                      });
                    },

                    icon: Icon(Icons.backspace_sharp,color: Colors.grey,size: 28,)
                ),
              )
            ],
          ),
          Row(
            children: [
                       buttons(text: "1"),
                       buttons(text: "2"),
                       buttons(text: "3"),
                       buttons(text: "×",textcolor: Colors.orangeAccent,),
            ],
          ),
          Row(
            children: [
              buttons(text: "4"),
              buttons(text: "5"),
              buttons(text: "6"),
              buttons(text: "+",textcolor: Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              buttons(text: "7"),
              buttons(text: "8"),
              buttons(text: "9"),
              buttons(text: "-",textcolor: Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              buttons(text: "."),
              buttons(text: "0"),
              buttons(text: "/",textcolor: Colors.orangeAccent),
              buttons(text: "=",buttonC: Colors.deepOrangeAccent),
            ],
          ),
        ],
      )
    );
  }

  Widget buttons({text,textcolor=Colors.white,buttonC=buttonColor}){
     return Expanded(
        child: Container(
          margin: EdgeInsets.all((5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:buttonC,
                padding: EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onPressed: (){
                    onclick(text);
            },
            child: Text(text,style: TextStyle(
                fontSize: 26,
                color: textcolor,
                fontWeight: FontWeight.bold
            ),),

          ),
        )
    );
  }
}
