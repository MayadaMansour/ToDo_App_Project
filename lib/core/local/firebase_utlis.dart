import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_project/core/model/task_model.dart';

class FireBaseUtlis {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTasksToFireBase(Task task) {
    var taskCollectionReference = getTaskCollection();
    DocumentReference<Task> documentReference = taskCollectionReference.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static Future<void> deleteTasksToFireBase(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
}
