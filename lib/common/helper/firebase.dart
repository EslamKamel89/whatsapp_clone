// Firebase
// ignore_for_file: unused_import
import 'dart:convert';
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:whatsapp/common/extension/extensions.dart';

FbAuth fbAuth = FbAuth();

/// old documentation https://firebase.flutter.dev/docs/auth/start/
///
/// new documentation https://firebase.google.com/docs/auth/flutter/start
class FbAuth {
  String? info;

  /// ==> The method returns true if the user is loged in
  ///
  /// ==> Events are fired when the following occurs:
  ///
  /// Right after the listener has been registered.
  ///
  /// When a user is signed in.
  ///
  /// When the current user is signed out.
  ///
  /// ==> https://firebase.google.com/docs/auth/flutter/manage-users
  ///
  /// ==> https://firebase.google.com/docs/auth/flutter/start
  bool isSignedIn() {
    info = '';
    'isSignedIn - FbAuth'.prt;
    if (FirebaseAuth.instance.currentUser == null) {
      info = 'User is currently signed out!'.pr;
      return false;
    } else {
      info = 'User is signed in!'.pr;
      return true;
    }
  }

  /// Create a password-based account
  ///
  /// returns true if the new account is created successfuly
  ///
  /// Typically, you would do this from your app's sign-up screen. When a new user
  /// signs up using your app's sign-up form, complete any new account validation
  /// steps that your app requires, such as verifying that the new account's password
  /// was correctly typed and meets your complexity requirements.
  ///
  /// If the new account was created successfully, the user is also signed in.
  /// If you are listening to changes in authentication state, a new event will
  /// be sent to your listeners.
  ///
  /// https://firebase.google.com/docs/auth/flutter/password-auth
  Future<bool> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    'createUserWithEmailAndPassword - FbAuth'.prt;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      info = 'New user is created successfully'.pr;
      return true;
    } on FirebaseAuthException catch (e) {
      'Error caught by try and catch block'.pr;
      if (e.code == 'weak-password') {
        info = 'The password provided is too weak.'.pr;
      } else if (e.code == 'email-already-in-use') {
        info = 'The account already exists for that email.'.pr;
      }
      info = e.code.pr;
      return false;
    } catch (e) {
      'Error caught by try and catch block'.pr;
      info = '$e'.pr;
      return false;
    }
  }

  /// Sign in a user with an email address and password
  ///
  /// The steps for signing in a user with a password are similar to the steps for creating a
  /// new account. From your your app's sign-in screen, call signInWithEmailAndPassword()
  ///
  /// this function returns true if sign in succeded & perform the sign in process
  ///
  /// https://firebase.google.com/docs/auth/flutter/password-auth
  Future<bool> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    'signInWithEmailAndPassword - FbAuth'.prt;
    bool isValidUser = false;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      isValidUser = true;
      info = 'Signed in successfully'.pr;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        info = 'No user found for that email.'.pr;
      } else if (e.code == 'wrong-password') {
        info = 'Wrong password provided for that user.'.pr;
      } else {
        info = 'Wrong Email or Password'.pr;
      }
    }
    return isValidUser;
  }

  /// sign out from normal email account
  /// sign out from google account
  Future<void> signOut() async {
    'signOut - fbAuth'.prt;
    await FirebaseAuth.instance.signOut();
    GoogleSignIn googleSignIn = GoogleSignIn();
//there is asynchronus gap errer
/* GoogleSignInApi.disconnect (c:\Users\LORD TRADE\AppData\Local\Pub\Cache\hosted\pub.dev\google_sign_in_android-6.1.20\lib\src\messages.g.dart:299)
<asynchronous gap> (Unknown Source:0)
GoogleSignIn._callMethod (c:\Users\LORD TRADE\AppData\Local\Pub\Cache\hosted\pub.dev\google_sign_in-6.1.6\lib\google_sign_in.dart:278)
<asynchronous gap> (Unknown Source:0) */
// i solved this issue by checking if user is looged in with google
    if ((await googleSignIn.isSignedIn()) == true) {
      googleSignIn.disconnect();
      info = 'google user is signing out'.pr;
      return;
    }
    info = 'normal user is signing out'.pr;
  }

  /// Send a user a verification email
  ///
  /// https://firebase.google.com/docs/auth/flutter/manage-users
  void sendEmailVerification() {
    'sendEmailVerification - FbAuth'.prt;
/* Send a user a verification email
You can send an address verification email to a user with the sendEmailVerification()
You can customize the email template that is used in Authentication section of the Firebase console, on the Email Templates p age. See Email Templates in Firebase Help Center.
It is also possible to pass state via a continue URL to redirect back to the app when sending a verification email.
Additionally you can localize the verification email by updating the language code on the Auth instance before sending the em ail. For example:
await FirebaseAuth.instance.setLanguageCode("fr");
await user?.sendEmailVerification();
https://firebase.google.com/docs/auth/flutter/manage-users */
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    info = 'Email Verification Send Please check your inbox'.pr;
  }

  /// Send a password reset email
  ///
  /// if the email is not correct it won't generate any info related to this
  Future<void> sendPasswordResetEmail({required String email}) async {
    'sendPasswordResetEmail - FbAuth'.prt;
/* Send a password reset email
You can send a password reset email to a user with the sendPasswordResetEmail() method.
You can customize the email template that is used in Authentication section of the Firebase console, on the Email Templates p age. See Email Templates in Firebase Help Center.
It is also possible to pass state via a continue URL to redirect back to the app when sending a password reset email.
https://firebase.google.com/docs/auth/flutter/manage-users */
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).onError((error, stackTrace) {
        'Error ocurred : $error'.pr;
        info = 'Unable to send verification email'.pr;
      });
    } catch (e) {
      'Error ocurred : $e'.pr;
      info = 'Unable to send verification email'.pr;
    }
    info = 'Reset Email is sended successfuly to your email'.pr;
  }

  /// The users display name.
  /// Will be null if signing in anonymously or via password authentication.
  String? get getName {
    'getName - FbAuth'.prt;
    info = FirebaseAuth.instance.currentUser?.displayName.pr;
    return info;
  }

  /// The users email address. Will be null if signing in anonymously.
  String? get getEmail {
    'getEmail - FbAuth'.prt;
    info = FirebaseAuth.instance.currentUser?.email.pr;
    return info;
  }

  /// Returns the users phone number.
  /// This property will be null if the user has not signed in or been has their phone number linked.
  String? get getPhoneNumber {
    'getPhoneNumber - FbAuth'.prt;
    info = FirebaseAuth.instance.currentUser?.phoneNumber.pr;
    return info;
  }

  /// Returns whether the users email address has been verified.
  /// To send a verification email, see [sendEmailVerification].
  /// Once verified, call [reload] to ensure the latest user information is retrieved from Firebase.
  bool? get getIsEmailVerified {
    'getIsEmailVerified - FbAuth'.prt;
    bool? result = FirebaseAuth.instance.currentUser?.emailVerified;
    info = '$result'.pr;
    FirebaseAuth.instance.currentUser?.reload();
    return result;
  }

  /// The user's unique ID.
  String? get getUid {
    'getName - FbAuth'.prt;
    info = FirebaseAuth.instance.currentUser?.uid.pr;
    return info;
  }

  /// signInWithGoogle returns true if signIn Process works successfuly
  Future<bool> signInWithGoogle() async {
    'signInWithGoogle - FbAuth'.prt;
    info = '';
/* Google
Most configuration is already setup when using Google Sign-In with Firebase, however you need to ensure your machine's SHA1 key has been configured for use with Android.
https://firebase.google.com/docs/auth/flutter/federated-auth */
    try {
// Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
// if googleUser or googleAuth is null this will throw exception in the lines below
      if (googleUser == null || googleAuth == null) {
        info = 'Error happened in googleAuth'.pr;
        return false;
      }
// Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
// Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      await userCredential.user!.reload();
// bool result = userCredential.additionalUserInfo?.isNewUser ?? false;
      bool result = getIsEmailVerified ?? false;
      result ? info = 'Sign in with Google completed successfuly'.pr : info = 'Could not connect with google'.pr;
      return result;
    } catch (e) {
      'error caught by try and catch block: $e'.pr;
    }
    return false;
  }
}

// very important link explains how data model in firebase work
// https://firebase.google.com/docs/firestore/data-model
class FbCloudFireStore {
  String? info;
  FbCloudFireStore() {
// Before using Firestore, you must first have ensured you have initialized FlutterFire.
// To create a new Firestore instance, call the instance getter on FirebaseFirestore:
// https://firebase.flutter.dev/docs/firestore/usage
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  }
  Future<void> createCollectionReference() async {
// Gets a [CollectionReference] for the specified Firestore path.
    FirebaseFirestore.instance.collection('String collectionName');
  }

  Future<void> addDocumentToNamedCollection() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// => https://firebase.flutter.dev/docs/firestore/usage
// => the function bellow add a document of type Map to a named collection
// => .add() Returns a DocumentReference with an auto-generated ID, after populating it with provided [data].
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('String Collection Name');
    collectionReference.add(' Map<String, Object?> document').then(
      (value) {
        info = 'document added successfuly';
// documentReference = value;
// this is the id for the document you should save it to be able to modify the notes later on
        value.id.pr;
      },
    ).catchError(
      (error) => info = "Failed to add document: $error",
    );
  }

  Future<void> QuerySnapshot_DocumentSnapshot() async {
// ------------------------------------------------------------------------------------------------------------------------------------
/* <<<A QuerySnapshot>>>
=> https://firebase.flutter.dev/docs/firestore/usage
=> A QuerySnapshot is returned from a collection query, and allows you to inspect the collection,
such as how many documents exist within it, gives access to the documents within the collection, see
any changes since the last query and more.
=> To access the documents within a QuerySnapshot, call the docs property, which returns a List
containing DocumentSnapshot classes. */
    FirebaseFirestore.instance.collection('String Collection Name').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
// .data() get the document as a Map
        doc.data().pr;
// .id gets the document id
        doc.id.pr;
      }
    });
// ------------------------------------------------------------------------------------------------------------------------------------
// <<< querig using where >>>
// you could query through the documnet list using a condition like fetching data for the current user
// .where (Object field, {Object? isEqualTo, Object? isNotEqualTo, Object? isLessThan, Object? isLessThanOrEqualTo,
// Object? isGreaterThan, Object? isGreaterThanOrEqualTo, Object? arrayContains, Iterable<Object?>? arrayContainsAny,
// Iterable<Object?>? whereIn, Iterable<Object?>? whereNotIn, bool? isNull)
// Creates and returns a new [Query] with additional filter on specified [field]. [field] refers to a field in a document.
    FirebaseFirestore.instance
        .collection('String Collection Name')
        .where('userId', isEqualTo: fbAuth.getUid)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
// .data() get the document as a Map
          doc.data().pr;
// .id gets the document id
          doc.id.pr;
        }
      },
    );
// ------------------------------------------------------------------------------------------------------------------------------------
/* <<< DocumentSnapshot>>>
=> https://firebase.flutter.dev/docs/firestore/usage
=> A DocumentSnapshot is returned from a query, or by accessing the document directly. Even if
no document exists in the database, a snapshot will always be returned.
=> To determine whether the document exists, use the exists property: */
    FirebaseFirestore.instance
        .collection('String Collection Name')
        .doc('String document id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        'Document exists on the database'.pr;
// .data() get the document as a Map
        documentSnapshot.data().pr;
// .id gets the document id
        documentSnapshot.id.pr;
      }
    });
  }

  Future<void> DeleteDocument_DeleteDocumentField() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// To delete documents with Cloud Firestore, you can use the delete method on a DocumentReference:
// https://firebase.flutter.dev/docs/firestore/usage
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('String Collection Name');
    collectionReference
        .doc('String doc id')
        .delete()
        .then(
          (value) => print("document Deleted"),
        )
        .catchError(
          (error) => print("Failed to delete document: $error"),
        );
// ------------------------------------------------------------------------------------------------------------------------------------
// https://firebase.flutter.dev/docs/firestore/usage
// If you need to remove specific properties from within a document rather than the document itself, you
// can use the delete method with the FieldValue class:
    CollectionReference collectionReference1 = FirebaseFirestore.instance.collection('String Collection Name');
    collectionReference1
        .doc('String doc id')
        .update({'field name': FieldValue.delete()})
        .then(
          (value) => print("document's Property Deleted"),
        )
        .catchError(
          (error) => print("Failed to delete document's property: $error"),
        );
  }

  Future<void> UpdateDocument() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// <<update>>
// https://firebase.flutter.dev/docs/firestore/usage
// Sometimes you may wish to update a document, rather than replacing all of the data. The set
// method above replaces any existing data on a given DocumentReference. If you'd like to update a
// document instead, use the update method:
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('String Collection name');
    collectionReference
// Returns a DocumentReference with the provided path.
        .doc('document id')
// Objects key can be a String or a FieldPath.
        .update({'field name or field path': 'new value'})
        .then((value) => print("Document Updated"))
        .catchError((error) => print("Failed to update Document: $error"));
  }

  Future<void> AddingAndUpatingDocumentsUsing_set() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// <<set>>
// https://firebase.flutter.dev/docs/firestore/usage
// The add method adds the new document to your collection with a unique
// auto-generated ID. If you'd like to specify your own ID, call the set method
// on a DocumentReference
// Calling set with an id that already exists on the collection will replace all the
// document data.
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('String collection name');
    collectionReference
// existing document id or new user defined id
        .doc('user defined id')
        .set({'field name': "data", 'field name 2': "data"})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
// ------------------------------------------------------------------------------------------------------------------------------------
// <<set with merging enabled>>
// https://firebase.flutter.dev/docs/firestore/usage
// You can also specify SetOptions(merge: true)) on the query, and this
// will merge the existing document with the data passed into the set():
    collectionReference
// existing document id
        .doc('existing document id')
        .set(
          {'field name': "data", 'field name 2': "data"},
          SetOptions(merge: true),
        )
        .then((value) => "new data merged successfuly with existing data!".pr)
        .catchError((error) => "Failed to merge data: $error".pr);
  }

  Future<void> CreatingNestedCollectionsInsideDocument() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// <<nested collection inside document>>
    QuerySnapshot querySnapshot = await FirebaseFirestore. //
        instance
        .collection('String Collection name')
        .doc('document id')
        .collection('String nested collection name')
        .get();
    List documentList = [];
    String? documentId;
    for (var doc in querySnapshot.docs) {
      documentList.add(doc.data());
      documentId = doc.id;
    }
  }

  Future<void> FilteringThroughDocuments_SortingDocumets_LimitNumberOfDocuments_StartAt_EndsAfter() async {
// ------------------------------------------------------------------------------------------------------------------------------------
// <<< querig using where >>>
// you could query through the documnet list using a condition like fetching data for the current user
// .where (Object field, {Object? isEqualTo, Object? isNotEqualTo, Object? isLessThan, Object? isLessThanOrEqualTo,
// Object? isGreaterThan, Object? isGreaterThanOrEqualTo, Object? arrayContains, Iterable<Object?>? arrayContainsAny,
// Iterable<Object?>? whereIn, Iterable<Object?>? whereNotIn, bool? isNull)
// Creates and returns a new [Query] with additional filter on specified [field]. [field] refers to a field in a document.
    FirebaseFirestore.instance
        .collection('String Collection Name')
        .where('userId', isEqualTo: fbAuth.getUid)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
// .data() get the document as a Map
          doc.data().pr;
// .id gets the document id
          doc.id.pr;
        }
      },
    );
// ------------------------------------------------------------------------------------------------------------------------------------
// <<< querig using where , orderBy , limit , startsAfter and endsAt>>>
    QuerySnapshot querySnapshot = await FirebaseFirestore. //
        instance
        .collection('MAIN COLLECTION NAME')
        .doc('MAIN DOCUMENT NAME')
        .collection('sub collection name')
        .where('field name', isGreaterThanOrEqualTo: 5)
        .orderBy('field name', descending: true)
// To start and/or end a query at a specific point within a collection, you can pass a value to the
// startAt, endAt, startAfter or endBefore methods. You must specify an order to use cursor queries,
// for example:
        .startAt([4, 'Alphabet Inc.'])
        .endAt([21, 'Google LLC'])
// Creates and returns a new Query that's additionally limited to only return up to
//the specified number of documents.
        .limit(5)
        .get();
  }

  Future<void> Transactions() async {
// <<<Transactions>>>
// https://firebase.flutter.dev/docs/firestore/usage
// => Transactions are a way to ensure that a write operation only occurs using the latest data available
// on the server. Transactions never partially apply writes, and writes execute at the end of a successful
// transaction.
// => When using transactions, note that:
// Read operations must come before write operations
// Transactions will fail when the client is offline, they cannot use cached data
// => An example of where a transaction could be used would be in an application where a user can
// subscribe to a channel. When a user presses the subscribe button, a "subscribers" field in a
// document increments. Without using Transactions, we would first need to read the existing value,
// and then increment that value using two separate operations.
// => On a high traffic application, the value on the server could have already changed by the time
// the write operation sets a new value, causing the number to be inconsistent.
// => Transactions remove this issue by atomically updating the value of the server. If the value changes
// whilst the transaction is executing, it will retry, ensuring the value on the server is used, rather
// than the client value.
// Create a reference to the document the transaction will use
    DocumentReference documentReference = FirebaseFirestore //
        .instance
        .collection('users')
        .doc('documentId');
    FirebaseFirestore.instance
        .runTransaction((transaction) async {
// Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);
          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }
// Update the follower count based on the current count
// Note: this could be done without a transaction
// by updating the population using FieldValue.increment()
          int newFollowerCount = (snapshot.data().toMap['followers'] as int) + 1;
// Perform an update on the document
          transaction.update(documentReference, {'followers': newFollowerCount});
// Return the new count
          return newFollowerCount;
        })
        .then((value) => print("Follower count updated to $value"))
        .catchError((error) => print("Failed to update user followers: $error"));
  }

  Future<void> BatchWrite() async {
// <<<Batch write>>>
// https://firebase.flutter.dev/docs/firestore/usage
// => Firestore lets you execute multiple write operations as a single batch that can contain
// any combination of set, update, or delete operations.
// => First, create a new batch instance via the batch method, then perform the operations on
// the batch, and then commit it once ready. The below example shows how to delete all documents
// in a collection in a single operation:
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');
    WriteBatch batch = FirebaseFirestore.instance.batch();
    collectionReference.get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        batch.delete(document.reference);
      }
      return batch.commit();
    });
// ----------------------------------------------------------------------------------------------------------------
// another way for writing the obove code
    CollectionReference collectionReference1 = FirebaseFirestore.instance.collection('users');
    WriteBatch batch1 = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot = await collectionReference1.get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      batch1.update(doc.reference, {'money': 0});
    }
    await batch1.commit();
  }

  Future<void> RealTimeChanges_StreamBuilder() async {
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------
// <<<Realtime changes#>>>
// => https://firebase.flutter.dev/docs/firestore/usage
// => FlutterFire provides support for dealing with realtime changes to collections
// and documents. A new event is provided on the initial request, and any subsequent
// changes to collection/document whenever a change occurs (modification, deleted or added).
// => Both the CollectionReference & DocumentReference provide a snapshots() method which
// returns a Stream:
// => Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
// => Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();
// => Once returned, you can subscribe to updates via the listen() method. The below example
// uses a StreamBuilder which helps automatically manage the streams state and disposal of the stream
// when it's no longer used within your app:
    final Stream<QuerySnapshot> collectionQueryStream =
        FirebaseFirestore.instance.collection('Collection name').snapshots();
    StreamBuilder<QuerySnapshot>(
      stream: collectionQueryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
// --------------------------------------------------------------------------------------------------------------------------------
// I will rewrite the previous code using itemBuilder a simpler way to
// achievieng the same result
    final Stream<QuerySnapshot> collectionQueryStream1 =
        FirebaseFirestore.instance.collection('Collection name').snapshots();
    StreamBuilder<QuerySnapshot>(
      stream: collectionQueryStream1,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
// return ListView(
// children: snapshot.data!.docs.map((DocumentSnapshot document) {
// Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
// return ListTile(
// title: Text(data['full_name']),
// subtitle: Text(data['company']),
// );
// }).toList(),
// );
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(title: Text(snapshot.data!.docs[index]['name'])),
            );
          },
        );
      },
    );
  }
}

class FbCloudStorage {
// i used image picker package to pick an image from gallery or take photo from the camera
// then upload it to the cloudStorage
  /* Future<void> PickImageAndUploadToCloudStorage(ImageSource imageSource) async {
    io.File? imageFile;
    String? url;
    try {
      XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      imageFile = io.File(image.path);
      String imageName = path.basename(imageFile.path);
      Reference refStorage = FirebaseStorage.instance.ref(imageName);
      await refStorage.putFile(imageFile);
      'The downoad link for the image'.prt;
      url = await refStorage.getDownloadURL();
      url.pr;
// setState(() {});
    } on PlatformException catch (e) {
      'Error Ocurred With ImagePicker'.prt;
      'Error : $e'.pr;
    }
  }*/
}

class FbMessaging {
  Future<void> GetToken() async {
// getToken(): Returns the default FCM token for this device.
// => On initial startup of your app, the FCM SDK generates a registration token for the
// client app instance.
// => the token could be rotated after initial startup, you are strongly recommended to retrieve
// the latest updated registration token.
// => The registration token may change when:
// The app is restored on a new device
// The user uninstalls/reinstall the app
// The user clears app data.
// ---------- there are twos services avaliable with firebase messaging
// 1 => Firebase Notification messages: The notification messages appears only when the app is in background mode or closed
// Users will receive notification messages even if they are outside of your app.
// 2 => Firebase In-App messages : Send an In-App message to get active users in your app to
// subscribe, watch a video, complete a level, or buy an item. Users will only be able to receive
// in-app messages inside of your app.
// => the most common scenarion is to use firebase Notification messages
// => you can test the messaging notification service from the firebase console you must have the token
// of the device you want to send the notification to
// => if the app is open the notification will arive but will not be shown unless you used local notification
// to show the notification
// => remember to update the token when the user is signing in because the user token may be changed
// or the user is using more than one device
    String? myToken = await FirebaseMessaging.instance.getToken();
    'The current App TOKEN'.prt;
    'Token: $myToken'.pr;
  }

  Future<void> Permissons() async {
// ------------------------------------------------------------------------------------------------------------------------------------------------
// <<<permissons>>> for IOS and WEB
// https://firebase.flutter.dev/docs/messaging/permissions
// => android devices doesn't need any permisson to make the notification works
// => Before diving into requesting notification permissions from your users, it is important to understand how
// Apple and web platforms handle permissions.
// => Notifications cannot be shown to users if the user has not "granted" your application permission. The overall
// notification permission of a single application can be either be "not determined", "granted" or "declined". Upon
// installing a new application, the default status is "not determined".
// => In order to receive a "granted" status, you must request permission from your user (see below). The user can
// either accept or decline your request to grant permissions. If granted, notifications will be displayed based on
// the permission settings which were requested.
// => If the user declines the request, you cannot re-request permission, trying to request permission again will
// immediately return a "denied" status without any user interaction - instead the user must manually enable notification
// permissions from the device Settings UI (or via a custom UI).
// => As explained in the Usage documentation, permission must be requested from your users in order to display remote
// notifications from FCM, via the requestPermission API:
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    'AuthorizationStatus'.prt;
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      'User granted permission'.pr;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      'User granted provisional permission'.pr;
    } else {
      'User declined or has not accepted permission'.pr;
    }
  }

  Future<void> SendNotificationUsingApi() async {
// ----------------------------------------------------------------------------------------------------------------------------- -------------------
// <<<send notification using firebase api>>>
// https://stackoverflow.com/questions/37490629/firebase-send-notification-with-rest-api
/*
URL:
https://fcm.googleapis.com/fcm/send
Header:
"Content-Type": "application/json",
you go to the firebase console then navigate to project settings then enable api then copy
the server key and past it into the header
"Authorization": "key=<Server_key>"
BODY:
{
"to": "<Device FCM token>",
"notification": {
"title": "Check this Mobile (title)",
"body": "Rich Notification testing (body)",
"mutable_content": true,
"sound": "Tri-tone"
},
"data": {
"url": "<url of media image>",
"dl": "<deeplink action on tap of notification>"
}
}
*/
// ---------------------------------------------------------------------------------------------------------
// not all the fields in the api are essential to make the service work
/*
{
"to": "eNshoRnSTj6JzwCY09vAA9:APA91bENjnPkso10r4lY6g_xNNNQYn0R07GX1MEafDaAbkcYG6dyj6M1Amvt1Fw7PAXz6tQhB2gJ_ZeFKJ-trcYrPl4yhFPLbkcZ31B5ZyrE2enIrwITdv4dSjiknNC_0WszyUZXCDTf",
"notification": {
"title": "Warning API",
"body": "ESLAM AHMED KAMEL",
}
}
*/
    Future postNotification(String title, String message, String token) async {
// this function is autogenerated using thunder client
      var headersList = {
        'Accept': '*/*',
// 'User-Agent': 'Thunder Client (https://www.thunderclient.com)', you don't need this line
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA3LFsk98:APA91bFIFB92REqC3Y5v9FqyqvJOQIW_9g4I9acdTyCVk13MjvqnbL9Dc94HFbcXeP2MIlAZzxI5bOFarhVCi1s5VBqtQAvBUk9pYFke -FTufTZDaO5JjnhYr0IVSwszwf4LvnMY-2Ij',
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var body = {
        "to": token,
        "notification": {"title": title, "body": message}
      };
      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);
      var response = await req.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(responseBody);
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  Future<void> NotificationInForeground_onMessage() async {
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// <<<onMessage>>> foreground usage
// https://firebase.flutter.dev/docs/messaging/usage
// => Depending on a device's state, incoming messages are handled differently. To understand these scenarios & how
// to integrate FCM into your own application, it is first important to establish the various states a device can be in:
// 1-> foreground : When the application is open, in view & in use.
// 2-> background : When the application is open, however in the background (minimised). This typically occurs
// when the user has pressed the "home" button on the device, has switched to another app via the app switcher or has
// the application open on a different tab (web).
// 3-> terminated : When the device is locked or the application is not running. The user can terminate an app by
// "swiping it away" via the app switcher UI on the device or closing a tab (web).
// => Foreground messages: To listen to messages whilst your application is in the foreground, listen to the onMessage stream .
    onMessageForegroundMessaging() {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        'Got a message whilst in the foreground!'.prt;
        'Message data: ${message.data}'.pr;
        if (message.notification != null) {
          'Message also contained a notification:'.prt;
          ' title: ${message.notification!.title}'.pr;
          ' body: ${message.notification!.body}'.pr;
        }
      });
    }
  }

  Future<void> BackgroundMessage_InBackgroundAndTerminatedMode() async {
// <<<Background messages>>>
// https://firebase.flutter.dev/docs/messaging/usage
// => Handling messages whilst your application is in the background is a little different. Messages
// can be handled via the onBackgroundMessage handler. When received, an isolate is spawned
// (Android only, iOS/macOS does not require a separate isolate) allowing you to handle
// messages even when your application is not running.
// => There are a few things to keep in mind about your background message handler:
// 1 => It must not be an anonymous function.
// 2 => It must be a top-level function (e.g. not a class method which requires initialization).
// that means that the function can't be inside class and call it in main
    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
      'Got a message whilst in the badkground!'.prt;
      'Message data: ${message.data}'.pr;
      if (message.notification != null) {
        'Message also contained a notification:'.prt;
        ' title: ${message.notification!.title}'.pr;
        ' body: ${message.notification!.body}'.pr;
      }
    }

    void mainx() {
      WidgetsFlutterBinding.ensureInitialized();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
// runApp(MyApp());
    }
  }

  Future<void> SendingDataWithNotifications() async {
// you can add data to notification in form of a Map
/*
{
"to": "duzLdCLbRyy9kwNyS10EU_:APA91bHj6g42R0UbER7BLW0es9zzWGCO0IWOaSb3nXsS6-_iZLmGzaJZKhsHGeWX2mlu0hDrOuGza_fJhr4yblSbuteaZwmln8pnG1fgxRRmCXI54RnjxxNQuGxkq57ucRCyYkZdnXcH",
"notification": {
"title": "Warning API",
"body": "ESLAM AHMED KAMEL"
},
"data": {
"age": 34
}
}
*/
    Future postNotificationWithToken({
      required String title,
      required String message,
      required String token,
      required String serverKey,
      required Map<String, Object?> data,
    }) async {
// this function is autogenerated using thunder client
      var headersList = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
// you grap server key from project settings on firebase console
        'Authorization': 'key=$serverKey',
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var body = {
        "to": token,
        "notification": {"title": title, "body": message},
        "data": data,
      };
      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);
      var response = await req.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        'sending Post succeded'.prt;
        responseBody.pr;
      } else {
        'sending Post failed'.prt;
        response.reasonPhrase.pr;
      }
    }
  }

  Future<void> HandlingInteractionWithNotifications() async {
// <<<Handling Interaction>>>
// https://firebase.flutter.dev/docs/messaging/notifications
// Since notifications are a visible cue, it is common for users to interact with it (by pressing them).
// The default behavior on both Android & iOS is to open the application. If the application is terminated
// it will be started, if it is in the background it will be brought to the foreground.
// => Depending on the content of a notification, you may wish to handle the users interaction when the
// application opens. For example, if a new chat message is sent via a notification and the user presses it,
// you may want to open the specific conversation when the application opens.
// => The firebase-messaging package provides two ways to handle this interaction:
// 1 => getInitialMessage(): If the application is opened from a <<terminated>> state a Future containing a RemoteMessage
// will be returned. Once consumed, the RemoteMessage will be removed.
// 2 => onMessageOpenedApp: A Stream which posts a RemoteMessage when the application is opened from a <<background>> state.
// => The dfauilt behaviour is when pressing on the interaction the app opens when it's in the background
// ------------------------------------------------------------------------------------------------------------------------
// <<<onMessageOpenedApp>>> works when the app in the background
    BuildContext? context;
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (message.data['type'] == 'chat') {
          Navigator.pushNamed(context!, '/chat');
        }
      },
    );
// ------------------------------------------------------------------------------------------------------------------------
// <<<getInitialMessage()>>> works when the app is terminated
// i used both getInitialMessage and onMessageOpenedApp in the sae function
    Future<void> setupInteractedMessage(BuildContext context) async {
// Get any messages which caused the application to open from
// a terminated state.
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
// If the message also contains a data property with a "type" of "chat",
// navigate to a chat screen
      if (initialMessage != null) {
        'initialMessage - the app is teriminated'.prt;
        'the user pressed on the notification'.pr;
        if (initialMessage.data['type'] == 'chat') {
// Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Chat()));
        }
      }
// Also handle any interaction when the app is in the background via a
// Stream listener
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          'onMessageOpenedApp - the app in the background'.prt;
          'the user pressed on the notification'.pr;
          if (message.data['type'] == 'chat') {
// Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Chat()));
          }
        },
      );
    }
  }

  Future<void> Topics() async {
// <<<Topics>>>
// https://firebase.flutter.dev/docs/messaging/usage
// => There are two ways to subscribe to notification using tokens OR topics
// => topic is the right way to send notification for a large number of users.
// => Topics are a mechanism which allow a device to subscribe and unsubscribe from named PubSub
// channels, all managed via FCM. Rather than sending a message to a specific device by FCM token,
// you can instead send a message to a topic and any devices subscribed to that topic will receive
// the message.
// => Topics allow you to simplify FCM server integration as you do not need to keep a store of
// device tokens. There are, however, some things to keep in mind about topics:
    Future postNotificationWithTopic({
      required String title,
      required String message,
      required String topic,
      required String serverKey,
      required Map<String, Object?> data,
    }) async {
// this function is autogenerated using thunder client
      var headersList = {
        'Accept': '*/*',
// 'User-Agent': 'Thunder Client (https://www.thunderclient.com)', you don't need this line
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var body = {
        "to": "/topics/$topic",
        "notification": {"title": title, "body": message},
        "data": data,
      };
      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);
      var response = await req.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(responseBody);
      } else {
        print(response.reasonPhrase);
      }
    }

// To subscribe a device, call the subscribeToTopic method with the topic name:
    await FirebaseMessaging.instance.subscribeToTopic('weather');
// To unsubscribe from a topic, call the unsubscribeFromTopic method with the topic name:
    await FirebaseMessaging.instance.unsubscribeFromTopic('weather');
  }
}
