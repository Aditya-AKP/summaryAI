// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:marquee/marquee.dart';
// import 'package:summary_ai_app/controller/dashboard_controller.dart';
// import 'package:summary_ai_app/model/a_i_response.dart';
// import 'package:summary_ai_app/screen/summary_screen.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {

//   TextEditingController messageController = TextEditingController();

//   final formKey = GlobalKey<FormState>();
//   bool isLoading=true;

//   DashboardController controller = DashboardController();
//   late Map<String,List<AIResponse>> grouped;



//   @override
//   void initState(){
//     grouped = controller.getAllAIResponse();
//     super.initState();
//   }

//   Future<void> createNewSummary()async{
//     setState(() {
//       isLoading=true;
//     });
//     try{
//       String id = await controller.generateSummary(messageController.text);
//       setState(() {
//         isLoading=false;
//       });
//       if(context.mounted)Navigator.push(context, MaterialPageRoute(builder: (context)=>SummaryScreen(id: id)));
//     }catch(e){
//       print(e);
//       print("EXCEPTION OCCURS IN DASHBOARD: ${e.toString()}");
//       debugPrint(e.toString());
//     }
//     setState(() {
//       isLoading=false;
//     });  
//   }

//   // Function to display the bottom sheet card
//   void showBottomCard(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Allows sheet to resize when keyboard appears
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Form(
//           key: formKey,
//           child: Padding(
//             // Pushes the card up so the keyboard doesn't hide the text box
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//               left: 20,
//               right: 20,
//               top: 20,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Card only takes necessary space
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   keyboardType: TextInputType.multiline,
//                   minLines: 1,
//                   maxLines: 10,
//                   controller: messageController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     alignLabelWithHint: true,
//                     labelText: 'Enter Text',
//                   ),
//                   autofocus: true, // Automatically opens keyboard
//                   validator: (value){
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ElevatedButton(
//                     child: const Text('Summarize'),
//                     onPressed: (){
//                       // Validate returns true if the form is valid, or false otherwise.
//                       if (formKey.currentState!.validate()) {
//                         // If the form is valid, save the data to variables
//                         formKey.currentState!.save();
//                         //Process Here 
//                         createNewSummary();
//                       }
//                     }
                    
//                   ),
//                 ),
//                 const SizedBox(height: 20), // Bottom spacing
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("AI Summarizer",style: TextStyle(fontWeight: FontWeight.bold),),),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => showBottomCard(context),
//         child: const Icon(Icons.add),
//       ),
//       body:isLoading?Center(child: CircularProgressIndicator(),):
//       grouped.isEmpty
//       ?buildEmptyResponse()
//       :CustomScrollView(
//         slivers: grouped.entries.map((entry) {
//           return SliverMainAxisGroup(
//             slivers: [

//               SliverToBoxAdapter(
//                 child: dateHeader(entry.key),
//               ),

//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16,),
//                       child: responseCard(context,entry.value[index],),
//                     );
//                   },
//                   childCount: entry.value.length,
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       )
//     );
//   }

//   Widget buildEmptyResponse() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [

//             Icon(
//               Icons.history_edu_outlined,
//               size: 80,
//               color: Colors.grey,
//             ),

//             SizedBox(height: 24),

//             Text(
//               "No summaries yet",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             SizedBox(height: 12),

//             Text(
//               "Tap the + button below to generate your first summary.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget responseCard(BuildContext context,AIResponse item) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16),

//         leading: const Icon(
//           Icons.description_outlined,
//           size: 28,
//         ),

//         title: SizedBox(
//           height: 24,
//           child: Marquee(
//             text: item.title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//             blankSpace: 40,
//             velocity: 35,
//             startPadding: 10,
//             accelerationDuration: const Duration(milliseconds: 600),
//             decelerationDuration: const Duration(milliseconds: 600),
//           ),
//         ),

//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: Text(
//             DateFormat('hh:mm a').format(item.createdAt),
//           ),
//         ),

//         trailing: const Icon(Icons.chevron_right),

//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>SummaryScreen(id: item.id)));
//         },
//       ),
//     );
//   }

//   Widget dateHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }





import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:summary_ai_app/core/service/pdf_service.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:summary_ai_app/controller/dashboard_controller.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/screen/summary_screen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {

  final TextEditingController messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = true;

  DashboardController controller = DashboardController();

  late Map<String, List<AIResponse>> grouped;

  final PdfService pdfService = PdfService();

  String? selectedPdfName;

  @override
  void initState() {
    super.initState();
    grouped = controller.getAllAIResponse();
    isLoading = false;
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> createNewSummary() async {

    final text = messageController.text.trim();

    if (text.isEmpty) {

      _showErrorMessage("Please enter some text first.",);

      return;
    }

    // Close the text input bottom sheet.
    if (mounted) {
      Navigator.of(context).pop();
    }

    setState(() {
      isLoading = true;
    });

    try {

      String id = await controller.generateSummary(text);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(
            id: id,
          ),
        ),
      );

    } catch (e, stackTrace) {

      debugPrint(
        "EXCEPTION OCCURS IN DASHBOARD: ${e.toString()}",
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showErrorMessage(
        "Unable to generate summary. Please try again.",
      );
    }
  }

  void showInputOptions() {

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {

        return _buildInputOptions();

      },
    );
  }

  Widget _buildInputOptions() {

    return Container(

      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        30,
      ),

      decoration: const BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),

      ),

      child: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(
              bottom: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),


          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Create Summary",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),


          const SizedBox(height: 6),


          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Choose how you want to add your content.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),


          const SizedBox(height: 22),


          //======================================================
          // ENTER TEXT
          //======================================================

          _inputOptionTile(

            icon: Icons.edit_note_outlined,

            title: "Enter Text",

            subtitle: "Write or paste your content",

            color: Colors.blue,

            onTap: () {

              Navigator.pop(context);

              // Clear any previously selected PDF.
              selectedPdfName = null;

              messageController.clear();

              showBottomCard(context);

            },
          ),


          const SizedBox(height: 12),


          //======================================================
          // IMPORT PDF
          //======================================================

          _inputOptionTile(

            icon: Icons.picture_as_pdf_outlined,

            title: "Import PDF",

            subtitle: "Select a PDF up to 20 pages",

            color: Colors.red,

            onTap: () async {

              Navigator.pop(context);

              await _pickPdf();

            },
          ),

        ],
      ),
    );
  }

  Widget _inputOptionTile({

    required IconData icon,

    required String title,

    required String subtitle,

    required Color color,

    required VoidCallback onTap,

  }) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(18),

      child: Container(

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(

          color: Colors.grey.shade50,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: Colors.grey.shade200,
          ),

        ),

        child: Row(

          children: [

            Container(

              height: 52,

              width: 52,

              decoration: BoxDecoration(

                color: color.withOpacity(0.1),

                borderRadius: BorderRadius.circular(14),

              ),

              child: Icon(
                icon,
                color: color,
                size: 27,
              ),

            ),


            const SizedBox(width: 15),


            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    title,

                    style: const TextStyle(

                      fontSize: 16,

                      fontWeight: FontWeight.w600,

                    ),

                  ),

                  const SizedBox(height: 4),

                  Text(

                    subtitle,

                    style: TextStyle(

                      fontSize: 13,

                      color: Colors.grey.shade600,

                    ),

                  ),

                ],
              ),
            ),


            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
            ),

          ],
        ),
      ),
    );
  }

  void showBottomCard(BuildContext context) {

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      shape: const RoundedRectangleBorder(

        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),

      ),

      builder: (BuildContext context) {

        return StatefulBuilder(
          builder:(context,setSheetState){
          return Form(
          
            key: formKey,
          
            child: Padding(
          
              padding: EdgeInsets.only(
          
                bottom:
                    MediaQuery.of(context).viewInsets.bottom,
          
                left: 20,
          
                right: 20,
          
                top: 20,
          
              ),
          
              child: Column(
          
                mainAxisSize: MainAxisSize.min,
          
                crossAxisAlignment:
                    CrossAxisAlignment.start,
          
                children: [
          
                  //================================================
                  // Selected PDF
                  //================================================
          
                  _buildSelectedPdf(setSheetState),
          
          
                  //================================================
                  // TEXT FIELD
                  //================================================
          
                  TextFormField(
          
                    keyboardType:
                        TextInputType.multiline,
          
                    minLines: 5,
          
                    maxLines: 10,
          
                    controller: messageController,
          
                    decoration: InputDecoration(
          
                      border: const OutlineInputBorder(),
          
                      alignLabelWithHint: true,
          
                      labelText:
                          selectedPdfName == null
                              ? 'Enter Text'
                              : 'Extracted PDF Text',
          
                      hintText:
                          selectedPdfName == null
                              ? 'Write or paste your text here...'
                              : 'PDF text has been extracted here.',
          
                    ),
          
                    autofocus:
                        selectedPdfName == null,
          
                    validator: (value) {
          
                      if (value == null ||
                          value.trim().isEmpty) {
          
                        return "Please enter some text.";
          
                      }
          
                      return null;
          
                    },
                  ),
          
          
                  const SizedBox(height: 15),
          
          
                  //================================================
                  // SUMMARIZE BUTTON
                  //================================================
          
                  Align(
          
                    alignment:
                        Alignment.centerRight,
          
                    child: ElevatedButton.icon(
          
                      icon: const Icon(
                        Icons.auto_awesome,
                      ),
          
                      label: const Text(
                        'Summarize',
                      ),
          
                      onPressed: () {
          
                        if (formKey.currentState!
                            .validate()) {
          
                          formKey.currentState!.save();
          
                          createNewSummary();
          
                        }
          
                      },
          
                    ),
                  ),
          
          
                  const SizedBox(height: 20),
          
                ],
              ),
            ),
          );
          }
        );
      },
    );
  }

  Widget _buildSelectedPdf(StateSetter setSheetState) {

    if (selectedPdfName == null) {
      return const SizedBox.shrink();
    }


    return Container(

      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(

        color: Colors.red.shade50,

        borderRadius:
            BorderRadius.circular(12),

      ),

      child: Row(

        children: [

          Icon(
            Icons.picture_as_pdf_outlined,
            color: Colors.red.shade700,
          ),


          const SizedBox(width: 10),


          Expanded(

            child: Text(

              selectedPdfName!,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),

            ),
          ),


          IconButton(

            onPressed: () {

              setSheetState(() {

                selectedPdfName = null;

                messageController.clear();

              });

            },

            icon: const Icon(
              Icons.close,
              size: 20,
            ),

          ),

        ],
      ),
    );
  }

  Future<void> _pickPdf() async {

    try {

      final result =
          await FilePicker.platform.pickFiles(

        type: FileType.custom,

        allowedExtensions: ['pdf'],

        withData: true,

      );


      // User cancelled the picker.
      if (result == null) {
        return;
      }


      final file =
          result.files.single;


      if (file.bytes == null) {

        _showErrorMessage(
          "Unable to read the selected PDF.",
        );

        return;
      }


      final Uint8List bytes =
          file.bytes!;


      //==========================================================
      // CHECK PAGE COUNT
      //==========================================================

      final int pageCount =
          _getPdfPageCount(bytes);


      if (pageCount > 20) {

        _showErrorMessage(

          "This PDF has $pageCount pages. "
          "Only PDFs with up to 20 pages are supported.",

        );

        return;
      }


      //==========================================================
      // SHOW LOADING
      //==========================================================

      _showPdfLoading();


      //==========================================================
      // EXTRACT TEXT
      //==========================================================

      final String extractedText =
          await pdfService.extractText(bytes);


      if (!mounted) return;


      // Close loading dialog.
      Navigator.of(context).pop();


      //==========================================================
      // EMPTY PDF CHECK
      //==========================================================

      if (extractedText.trim().isEmpty) {

        _showErrorMessage(

          "No readable text was found in this PDF. "
          "It may be a scanned document.",

        );

        return;
      }


      //==========================================================
      // PUT TEXT INTO TEXTBOX
      //==========================================================

      setState(() {

        selectedPdfName =
            file.name;

        messageController.text =
            extractedText;

      });


      //==========================================================
      // OPEN TEXT INPUT
      //==========================================================

      showBottomCard(context);


    } catch (e, stackTrace) {

      debugPrint(
        "PDF extraction error: $e",
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );


      if (!mounted) return;


      // If loading dialog is open,
      // this will close it.
      Navigator.of(context).pop();


      _showErrorMessage(
        "Something went wrong while reading the PDF.",
      );
    }
  }

  int _getPdfPageCount(
      Uint8List bytes) {

    final PdfDocument document =
        PdfDocument(
      inputBytes: bytes,
    );

    try {

      return document.pages.count;

    } finally {

      document.dispose();

    }
  }

  void _showPdfLoading() {

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (_) {

        return const AlertDialog(

          content: Row(

            children: [

              SizedBox(

                height: 24,

                width: 24,

                child:
                    CircularProgressIndicator(
                  strokeWidth: 3,
                ),

              ),

              SizedBox(width: 18),

              Expanded(

                child: Text(
                  "Reading PDF...",
                ),

              ),

            ],
          ),
        );
      },
    );
  }

  void _showErrorMessage(
      String message) {

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(message),

        behavior:
            SnackBarBehavior.floating,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(

          "AI Summarizer",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),

        ),

      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed:
            showInputOptions,

        child: const Icon(
          Icons.add,
        ),

      ),

      body:

          isLoading

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : grouped.isEmpty

                  ? buildEmptyResponse()

                  : CustomScrollView(

                      slivers:

                          grouped.entries
                              .map(

                        (entry) {

                          return
                              SliverMainAxisGroup(

                            slivers: [

                              SliverToBoxAdapter(

                                child:
                                    dateHeader(
                                  entry.key,
                                ),

                              ),


                              SliverList(

                                delegate:
                                    SliverChildBuilderDelegate(

                                  (
                                    context,
                                    index,
                                  ) {

                                    return Padding(

                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 16,
                                      ),

                                      child:
                                          responseCard(

                                        context,

                                        entry.value[
                                            index],

                                      ),

                                    );

                                  },

                                  childCount:
                                      entry.value.length,

                                ),

                              ),

                            ],

                          );

                        },

                      ).toList(),

                    ),
    );
  }

  Widget buildEmptyResponse() {

    return Center(

      child: Padding(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 32,
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

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

                fontWeight:
                    FontWeight.bold,

              ),

            ),


            SizedBox(height: 12),


            Text(

              "Tap the + button below to "
              "generate your first summary.",

              textAlign:
                  TextAlign.center,

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

  Widget responseCard(
    BuildContext context,
    AIResponse item,
  ) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      elevation: 0,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(16),

      ),

      child: ListTile(

        contentPadding:
            const EdgeInsets.all(16),


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

              fontWeight:
                  FontWeight.bold,

            ),

            blankSpace: 40,

            velocity: 35,

            startPadding: 10,

            accelerationDuration:
                const Duration(
              milliseconds: 600,
            ),

            decelerationDuration:
                const Duration(
              milliseconds: 600,
            ),

          ),
        ),


        subtitle: Padding(

          padding:
              const EdgeInsets.only(
            top: 8,
          ),

          child: Text(

            DateFormat(
              'hh:mm a',
            ).format(
              item.createdAt,
            ),

          ),
        ),


        trailing: const Icon(
          Icons.chevron_right,
        ),


        onTap: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (context) =>
                  SummaryScreen(
                id: item.id,
              ),

            ),

          );

        },

      ),
    );
  }

  Widget dateHeader(String title) {

    return Padding(

      padding:
          const EdgeInsets.fromLTRB(
        16,
        18,
        16,
        12,
      ),

      child: Text(

        title,

        style: const TextStyle(

          fontSize: 22,

          fontWeight:
              FontWeight.bold,

        ),

      ),
    );
  }


}



