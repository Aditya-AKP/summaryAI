import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:summary_ai_app/controller/dashboard_controller.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/screen/summary_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  TextEditingController messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading=true;

  DashboardController controller = DashboardController();
  late Map<String,List<AIResponse>> grouped;



  @override
  void initState(){
    grouped = controller.getAllAIResponse();
    super.initState();
  }

  Future<void> createNewSummary()async{
    setState(() {
      isLoading=true;
    });
    try{
      String id = await controller.generateSummary(messageController.text);
      setState(() {
        isLoading=false;
      });
      if(context.mounted)Navigator.push(context, MaterialPageRoute(builder: (context)=>SummaryScreen(id: id)));
    }catch(e){
      print(e);
      print("EXCEPTION OCCURS IN DASHBOARD: ${e.toString()}");
      debugPrint(e.toString());
    }
    setState(() {
      isLoading=false;
    });  
  }

  // Function to display the bottom sheet card
  void showBottomCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows sheet to resize when keyboard appears
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: Padding(
            // Pushes the card up so the keyboard doesn't hide the text box
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Card only takes necessary space
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Enter Text',
                  ),
                  autofocus: true, // Automatically opens keyboard
                  validator: (value){
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: const Text('Summarize'),
                    onPressed: (){
                      // Validate returns true if the form is valid, or false otherwise.
                      if (formKey.currentState!.validate()) {
                        // If the form is valid, save the data to variables
                        formKey.currentState!.save();
                        //Process Here 
                        createNewSummary();
                      }
                    }
                    
                  ),
                ),
                const SizedBox(height: 20), // Bottom spacing
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Summarizer",style: TextStyle(fontWeight: FontWeight.bold),),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomCard(context),
        child: const Icon(Icons.add),
      ),
      body:isLoading?Center(child: CircularProgressIndicator(),):
      grouped.isEmpty
      ?buildEmptyResponse()
      :CustomScrollView(
        slivers: grouped.entries.map((entry) {
          return SliverMainAxisGroup(
            slivers: [

              SliverToBoxAdapter(
                child: dateHeader(entry.key),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,),
                      child: responseCard(context,entry.value[index],),
                    );
                  },
                  childCount: entry.value.length,
                ),
              ),
            ],
          );
        }).toList(),
      )
    );
  }

  Widget buildEmptyResponse() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.history_edu_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 24),

            Text(
              "No summaries yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Text(
              "Tap the + button below to generate your first summary.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget responseCard(BuildContext context,AIResponse item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: const Icon(
          Icons.description_outlined,
          size: 28,
        ),

        title: SizedBox(
          height: 24,
          child: Marquee(
            text: item.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            blankSpace: 40,
            velocity: 35,
            startPadding: 10,
            accelerationDuration: const Duration(milliseconds: 600),
            decelerationDuration: const Duration(milliseconds: 600),
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            DateFormat('hh:mm a').format(item.createdAt),
          ),
        ),

        trailing: const Icon(Icons.chevron_right),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SummaryScreen(id: item.id)));
        },
      ),
    );
  }

  Widget dateHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}