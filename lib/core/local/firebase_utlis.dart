import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_project/core/model/task_model.dart';
import 'package:todo_app_project/core/model/user_model.dart';

class FireBaseUtlis {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getCollectionUser()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTasksToFireBase(Task task, String uId) {
    var taskCollectionReference = getTaskCollection(uId);
    DocumentReference<Task> documentReference = taskCollectionReference.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static Future<void> deleteTasksToFireBase(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTaskInFireBase(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).set(task);
  }

  static CollectionReference<MyUser> getCollectionUser() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: ((snapshot, option) =>
                MyUser.fromFireStore(snapshot.data())),
            toFirestore: ((myUser, option) => myUser.toFireStore()));
  }

  static Future<void> addUserToFireBase(MyUser user) {
    return getCollectionUser().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireBase(String id) async {
    var querySnapShot = await getCollectionUser().doc(id).get();
    return querySnapShot.data();
  }
}
