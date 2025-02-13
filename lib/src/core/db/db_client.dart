abstract class DbClient {
  Future<void> insert(Map<String, dynamic> data);
  Future<void> delete(int id);
  Future<List<Map<String, dynamic>>> query();
  Future<Map<String, dynamic>?> getItemFromID(String id);
}
