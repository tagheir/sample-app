// extension GeneralExtensions on Object {
//   Future<T> getFuture<T>() {
//     return Future.value(this);
//   }
// }

extension JsonMapExtensions on Map<String, dynamic> {
  dynamic get(String key) {
    if (this == null) return null;
    if (this.containsKey(key) == false) return null;
    return this[key];
  }
}
