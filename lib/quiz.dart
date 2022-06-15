import 'dart:io';

class Question {
  String question;
  String answer;

  Question({required this.question, required this.answer});
}

List<Question> _question=[
  Question(question: "What is the capital of algeria", answer: "algiers",),
  Question(question: "1+1 = ?", answer: "2"),
  Question(question: "Is Tlemcen good city", answer: "no",),
  Question(question: "2 x 2 =?", answer: "4",),
  Question(question: "What is the capital of France", answer: "paris",),
];


class CheckAnswer {
  String inanswer;
  int index;
  CheckAnswer({required this.inanswer,required this.index});


  bool check(){
    bool iss = false;
    inanswer== _question[index].answer ? iss=true :1;
    return iss;
  }




}


void main() {
    String answer;
    int score=0;

    for(int i=0;i<_question.length;i++){
      print(_question[i].question);
      answer = stdin.readLineSync().toString().toLowerCase();

      if(CheckAnswer(inanswer: answer,index: i).check()){
        score+=20;
      }
      else continue;

    }
    
    
    print("\n your score is $score");








}
