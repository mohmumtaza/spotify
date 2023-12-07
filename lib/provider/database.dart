import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:spotify/controller/auth_appwrite_helper.dart';
import 'package:spotify/model/list_model.dart';
import 'package:spotify/provider/client.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static DatabaseHelper get instance => _instance;

  static Databases? databases;

  init() {
    databases = Databases(client);
  }

  createTodo({
    required String title,
    required String description,
  }) async {
    databases ?? init();
    try {
      String? userId = await AuthHelper.instance.getUserId();
      await databases!.createDocument(
          databaseId: "655f5e34d937416d6b53",
          collectionId: "655f5e79d17b5ec37169",
          documentId: ID.unique(),
          data: {
            "title": title,
            "description": description,
            "isDone": false,
            "createdAt": DateTime.now().toIso8601String(),
            "userId": userId,
          });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  getTodos() async {
    databases ?? init();
    try {
      String userId = await AuthHelper.instance.getUserId() ?? "";
      DocumentList response = await databases!.listDocuments(
        databaseId: "655f5e34d937416d6b53",
        collectionId: "655f5e79d17b5ec37169",
        queries: [
          Query.equal("userId", userId),
        ],
      );
      return response.documents
          .map(
            (e) => TodoModel.fromJson(e.data, e.$id),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  void updateTodo(TodoModel todo) async {
    databases ?? init();
    try {
      await databases!.updateDocument(
        databaseId: "655f5e34d937416d6b53",
        collectionId: "655f5e79d17b5ec37169",
        documentId: todo.id,
        data: {
          "title": todo.title,
          "description": todo.description,
          "isDone": todo.isDone,
          "createdAt": todo.createdAt.toIso8601String(),
          "userId": todo.userId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void deleteTodo(String id) async {
    databases ?? init();
    try {
      await databases!.deleteDocument(
        databaseId: "655f5e34d937416d6b53",
        collectionId: "655f5e79d17b5ec37169",
        documentId: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}