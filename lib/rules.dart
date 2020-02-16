import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/whiteBg.png',
                ),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 26.0,),
              CustomTitle(text: 'ELIGIBILITY'),
              SizedBox(height: 26.0,),
              Content(
                text:
                    '•This competition is open and free for all willing hobbyist or professional photographers. There are no location restrictions. If the participant stays in a disputed region, delivery of prize(physical) is not possible.\n•A person should enter via one account only. If a person tries to enter using any secondary account then both entries will be considered invalid.\n•Images that have won prizes in prior competitions, have been used for commercial purposes or have been published will not be eligible.',
              ),
              SizedBox(height: 26.0,),
              CustomTitle(
                text: 'COPYRIGHT/INTELLECTUAL PROPERTY',
              ),
              SizedBox(height: 26.0,),
              Content(
                text:
                    '•Each image submitted must be the original and unpublished work created by the participant who is the copyright holder.\n\n•The copyright of the submitted entries will be solely held by the owner of photo (participant and owner must be the same).\n\n•Images received by the organiser through the competition will not be used by the organiser for commercial purposes.',
              ),
              SizedBox(height: 26.0,),
              CustomTitle(text: 'SUBMISSION OF ENTRIES',),
              SizedBox(height: 26.0,),
              Content(text: '•The participant can enter by posting the upto 3 best pictures(Help will be provided if any participant faces any issue submitting their entry).\n\n•There is a limit of one account per person, attempts to submit from more than one account will invalidate all entries of the specific participant.\n\n•The submitted image must not have a watermark of the owner. Entries with watermark on it will be considered invalid. Do not worry about issues regarding copyright of photo as the organisers will be very strict on the issue.',),
              SizedBox(height: 26.0,),
              CustomTitle(text:'JUDGING AND RESULTS'),
              SizedBox(height: 26.0,),
              Content(text: '•The images will be selected by a panel of judges and their decision will be final. No correspondence pertaining to the selection process and decision will be entertained.\n\n•Images will be judged based on originality, creativity, and relevance to the theme.\n\n•The judging panel reserves the right to withhold prizes if the images submitted fail to meet the requirements stated here.',),
              SizedBox(height: 26.0,),
              CustomTitle(text: 'PRIZES',),
              SizedBox(height: 26.0,),
              Content(text: '•Prizes are non-transferable and non-exchangeable for the equivalent cash value.\n\n•The organiser reserves the right to change or replace the competition prizes and/or modify the rules and regulations of the competition if it becomes necessary, without prior notice.\n\n•The organiser shall not be liable for any fault with any of the prizes. Any issues or queries relating to the condition of the prizes should be referred to the manufacturer and/or supplier of the prizes.',),
              SizedBox(height: 26.0,),
              CustomTitle(text: 'ACCEPTANCE OF RULES AND REGULATIONS',),
              SizedBox(height: 26.0,),
              Content(text: '•By submitting an image for the competition, the participant will be regarded as having accepted and agreed to be bound by the rules and regulations of the competition.\n\n•While the organiser will exercise due care during the collection, selection and storage of images the organiser shall not be held liable for any loss, theft, or destruction of the images.',),
              SizedBox(height: 26.0,),
              CustomTitle(text: 'ORGANISERS',),
              SizedBox(height: 26.0,),
              Content(text: '•The organiser and supporter of the event is @macroandflora (macroandflora.com, #macroandflora) and been sponsored by multiple companies.',),
            ],
          ),
        ),
      )),
    );
  }
}

class Content extends StatelessWidget {
  final String text;

  Content({Key key, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'George',
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String text;
  CustomTitle({Key key, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.0,fontFamily: 'George', color: Colors.black),
      ),
    );
  }
}
