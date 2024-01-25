import 'package:ahadith_offline_arabic_english/constants/all_ahadith.dart';
import 'package:flutter/material.dart';

class AllHadithScreen extends StatelessWidget {
  const AllHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(

        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: allAhadith.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Hadith ${allAhadith[index]['id']}  $index'),
          );
        },
      ),
    );
  }
}
//-----------------------------------------------------------------------------------------------------------------
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: SingleChildScrollView(
  //       child:Column(
  //         children:
  //           allAhadith.map((e) => ListTile(
  //             title: Text('${e['id']}'),
  //           )).toList(),
  //
  //       ),
  //     ),
  //   );
  // }
// }

//-----------------------------------------------------------------------------------------------------------------
//
// import 'package:flutter/material.dart';
//
// class AllHadithScreen extends StatefulWidget {
//   const AllHadithScreen({Key? key}) : super(key: key);
//
//   @override
//   _AllHadithScreenState createState() => _AllHadithScreenState();
// }
//
// class _AllHadithScreenState extends State<AllHadithScreen> {
//   List<Map<String, dynamic>> allAhadith = Ahadith.allAhadith; // Your data source
//   int itemsPerPage = 20; // Number of items to load per page
//   int currentPage = 1; // Current page number
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: ListView.builder(
//         itemCount: allAhadith.length + 1, // Add 1 for the loading indicator
//         itemBuilder: (context, index) {
//           if (index < allAhadith.length) {
//             return ListTile(
//               title: Text('Hadith ${allAhadith[index]['id']}  $index'),
//             );
//           } else {
//             // Reached the end, show loading indicator
//             return _buildLoadingIndicator();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildLoadingIndicator() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//
//   // Simulate loading more data (replace with your actual data fetching logic)
//   Future<void> _loadMoreData() async {
//     // Simulate a delay to represent fetching data from an API
//     await Future.delayed(Duration(seconds: 2));
//
//     // Fetch more data and append it to the existing list
//     List<Map<String, dynamic>> moreData = []; // Fetch your additional data
//     allAhadith.addAll(moreData);
//
//     // Update the UI to reflect the new data
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Initial data loading
//     _loadMoreData();
//   }
// }
