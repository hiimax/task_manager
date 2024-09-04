// import 'package:firebase_auth/firebase_auth.dart';

// class FireAuth { 
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; 
//   User? get currentUser => _firebaseAuth.currentUser; 
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges(); 
  
//   Future<void> signInWithEmailAndPassword({ 
//     required String email, 
//     required String password, 
//   }) async { 
//     await _firebaseAuth.signInWithEmailAndPassword( 
//       email: email, 
//       password: password, 
//     ); 
//   } 
  
//   Future<void> createUserWithEmailAndPassword({ 
//     required String email, 
//     required String password, 
//   }) async { 
//     await _firebaseAuth.createUserWithEmailAndPassword( 
//       email: email, 
//       password: password, 
//     ); 
//   } 
  
//   Future<void> signOut() async { 
//     await _firebaseAuth.signOut(); 
//   } 

//   void addData() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
  
//   await users.add({
//     'name': 'John Doe',
//     'email': 'john@example.com',
//     'age': 25,
//   });
// }


// void readData() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
  
//   // Retrieve all documents in the 'users' collection
//   QuerySnapshot querySnapshot = await users.get();
//   querySnapshot.docs.forEach((doc) {
//     print('Name: ${doc['name']}, Email: ${doc['email']}, Age: ${doc['age']}');
//   });

//   // Retrieve a specific document
//   DocumentSnapshot documentSnapshot = await users.doc('documentId').get();
//   print('Name: ${documentSnapshot['name']}, Email: ${documentSnapshot['email']}, Age: ${documentSnapshot['age']}');
// }

// void updateData() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
  
//   // Update data in a specific document
//   await users.doc('documentId').update({
//     'age': 26,
//   });
// }

// void deleteData() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
  
//   // Delete a specific document
//   await users.doc('documentId').delete();
// }
// }