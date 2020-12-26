// import 'dart:convert';
// import 'package:reflectable/reflectable.dart';
// import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

// class Reflection extends Reflectable {
//   const Reflection() : super(invokingCapability);
// }

// const reflection = Reflection();

// @reflection
// class GenericJsonClass<T> {
//   dynamic fromJson(String str) => fromMap<T>(json.decode(str));

//   dynamic fromMap<T>(Map<String, dynamic> json) {
//     T templatedObj;
//     //InstanceMirror instanceMirror = reflection.reflect(templatedObj);
//     ClassMirror classMirror = reflection.reflectType(T);
//     List<TypeVariableMirror> classVariable = classMirror.typeVariables.toList();

//     var classObj = classVariable.map((v) {
//       if (json.containsKey(v)) {
//         if (v.reflectedType.isPrimitiveType()) {
//           return json[v];
//         }
//         if (v.reflectedType.isList()) {
//           (v as List).forEach((obj) {
//             var type = obj.runtimeType;
//             return fromMap<dynamic>(json[obj]);
//           });
//         }
//         if (!v.reflectedType.isPrimitiveType() && !v.reflectedType.isList()) {
//           return fromMap(json[v]);
//         }
//       }
//     });
//     return classObj;
//   }
// }
