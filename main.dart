import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote/quotes.dart';



void main() => runApp( MaterialApp(

    home:HomeScreen()

));
class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override


  int selectionTapCount = 0;



  void _onDoubleTap() {
    setState(() {
      selectionTapCount += 1;
    });

    // Navigate to the quote screen
    if (selectionTapCount == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => quote()),
      ).then((value) {
        // Reset the selectionTapCount when coming back from the quote screen
        if (value == true) {
          setState(() {
            selectionTapCount = 0;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: NetworkImage(
                'https://i.pinimg.com/originals/19/32/4a/19324a087a3ff2fcd50154d9979231c5.gif'),
            fit: BoxFit.cover,
          ),
          Opacity(
            opacity: 0.9,
            child: Container(
              color: Colors.black,
            ),
          ),
          Center(
            child: Text(
              ' N O T E S ',
              style: GoogleFonts.rajdhani().copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                letterSpacing: 2,
              ),
            ),

          ),
          DoubleTapWidget(onDoubleTap: _onDoubleTap),
        ],

      ),

    );
  }
}

class quote extends StatefulWidget {


    @override


  State<quote> createState() => _quoteState();
}

class _quoteState extends State<quote> {
  List<Quote> quotes =[
    Quote(author:'باس',text: 'میں نے سمجھا تھا کہ تو ہے تو درخشاں ہے حیات '
'  تیرا غم ہے تو غم زہر کا جھگڑا کیا ہے'
 '  تیری صورت سے ہے عالم  میں بہاروں کو ثبات'
  'تیری آنکھوں کے سوا دنیا میں رکھا ہی کیا ہے'
  'تُو مل جائے تو تقدیر نگوں ہوجائے'
  'یوں نہ تھا'
  'میں نے فقط چاہا تھا یوں ہو جائے'
  'اور بھی دکھ ہیں زمانے میں محبت کے سوا'
  'راحتیں اور بھی ہیں وصل کی راحت کے سوا   '),
    Quote(author:'باس',text: 'لوگ پوچھتے پھرتے ہیں کہ کون ہے یہ آخر لو سنوں؟   لوگوں کے تلخ رویے کا ستایا ہوا شخص ہو میں گھر کے ہر فرد سے بیکار میں لڑ پڑتا ہو ۔'),
    Quote(author:'باس',text: 'لوگ پوچھتے پھرتے ہیں کہ کون ہے یہ آخر لو سنوں؟   لوگوں کے تلخ رویے کا ستایا ہوا شخص ہو میں گھر کے ہر فرد سے بیکار میں لڑ پڑتا ہو ۔'),
  ];
  int selectionTapCount = 0;
  void deleteQuote(int index) {
    setState(() {
      quotes.removeAt(index);
    });}
 Widget quoteTemplate(Quote quote,VoidCallback onDelete){
  return QuoteCard(quote:quote, delete:onDelete);

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          //toolbarHeight: MediaQuery.of(context).size.height * 0.07, // 50% of screen height
            flexibleSpace: Image(
              image:NetworkImage('https://i.pinimg.com/originals/8e/1e/85/8e1e853313ace4ffcf50b56f22f844d4.gif')
              ,fit:BoxFit.cover,
              // height: 100,
              // width: 1000,
            )
        ),

        body:  Stack(
              fit: StackFit.expand,
              children:[
                Container(

                    width: double.infinity,
                    height: 512,
                    //Set your desired height for the image
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/00/f8/51/00f851b8b4d16616dba717ff5273c350.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),

                      ),
                    )
                ,
          ),

              ListView.builder(
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    return quoteTemplate(
                        quotes[index],
                            () =>deleteQuote(index),
      );

                        },),


            ],
         //DoubleTapWidget(onDoubleTap: onDoubleTap_),
            ),



    floatingActionButton: FloatingActionButton(
    onPressed: () {
    // Navigate back to the HomeScreen when the button is pressed
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => selection()),
    );
    },
    child: Icon(Icons.dark_mode_outlined),
    backgroundColor: Colors.black,


    ),
    );
  }
}

class QuoteCard extends StatelessWidget {
 final Quote quote;
 final void Function() delete;
  QuoteCard({required this.quote,required this.delete });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.transparent,

      margin: EdgeInsets.fromLTRB(16,16 , 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Align(
              alignment: Alignment.topLeft, // Align text to the right
              child: Text(
                quote.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 0),
            Text(
                quote.author,
                style:TextStyle(
                  fontSize:14.0,
                  color:Colors.black,
                  fontWeight: FontWeight.bold,
                )
            ),
            SizedBox(height:2),
            FloatingActionButton(
              onPressed:delete,
              tooltip:'Delete',

              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn), // Change the color to your desired color
                child: Icon(Icons.delete),
              ),
              backgroundColor:Colors.transparent,
              elevation: 0,
            ),

          ],
        ),
      ),
    );
  }
}



class DoubleTapWidget extends StatefulWidget {
  final Function() onDoubleTap;

  DoubleTapWidget({required this.onDoubleTap});
  @override
  State<DoubleTapWidget> createState() => _DoubleTapWidgetState();
}

class _DoubleTapWidgetState extends State<DoubleTapWidget> {
  int tapCount = 0;


  void _onDoubleTap() {
    setState(() {
      tapCount += 1;
    });

    // Navigate to the next page
    if (tapCount == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => quote()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.transparent,

        child: Container(
          width: 100,
          height: 100,
          color: Colors.transparent, // Just for visibility, you can remove this color
          child: Text(
            ' $tapCount',
          ),
        ),
      ),
    );
  }
}


class selection extends StatefulWidget {


  @override
  State<selection> createState() => _selectionState();
}

class _selectionState extends State<selection> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor:Colors.cyan,
      ),*/
      body:Stack(
        fit: StackFit.expand,
        children:[
          Image(
            image:NetworkImage('https://i.pinimg.com/originals/8e/1e/85/8e1e853313ace4ffcf50b56f22f844d4.gif')
            ,fit:BoxFit.cover,
          ),

        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate back to the HomeScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Icon(Icons.dark_mode_outlined),
        backgroundColor: Colors.black,

      ),

    );

  }
}

