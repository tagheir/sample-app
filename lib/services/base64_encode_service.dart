
import 'dart:convert';

import 'dart:io';

class EncodeToBase64
{
   static String encodeImage({File image})
   {
      return base64Encode(image.readAsBytesSync());
   }
}