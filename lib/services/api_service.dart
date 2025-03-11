import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'https://gokeihub.github.io/bookify_api/new.json';

  Future<List<Author>> fetchAuthors() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // Print the raw response for debugging
        print('Raw API response: ${response.body}');
        
        final List<dynamic> decodedData = jsonDecode(response.body) as List<dynamic>;
        
        // Process each item carefully with proper type checking
        return decodedData.map((item) {
          // Ensure each item is properly cast to Map<String, dynamic>
          if (item is Map) {
            return Author.fromJson(Map<String, dynamic>.from(item));
          } else {
            throw Exception('Invalid author data format: $item');
          }
        }).toList();
      } else {
        throw Exception('Failed to load authors: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception details: $e');
      throw Exception('Failed to load authors: $e');
    }
  }
}


// const apiData = [{
//   "_id": {
//     "$oid": "67c3dfeca0eaea993eae8ca7"
//   },
//   "name": "রবীন্দ্রনাথ ঠাকুর",
//   "books": [
//     {
//       "title": "গোরা",
//       "cover": "https://i.postimg.cc/vB37vkP1/gora.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8ca8"
//       }
//     },
//     {
//       "title": "কাবুলিওয়ালা",
//       "cover": "https://i.postimg.cc/d00GV4Qw/kabuli-ola.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8ca9"
//       }
//     },
//     {
//       "title": "ঘরে বাইরে",
//       "cover": "https://i.postimg.cc/gjGzGBdK/ghore-baire.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8caa"
//       }
//     }
//   ],
//   "__v": 0
// },
// {
//   "_id": {
//     "$oid": "67c3dfeca0eaea993eae8cab"
//   },
//   "name": "শরৎচন্দ্র চট্টোপাধ্যায়",
//   "books": [
//     {
//       "title": "দেবদাস",
//       "cover": "https://i.postimg.cc/gJxRxfQ9/devdas.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cac"
//       }
//     },
//     {
//       "title": "পরিণীতা",
//       "cover": "https://i.postimg.cc/Y01xS5Lr/Parineeta.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cad"
//       }
//     },
//     {
//       "title": "চরিত্রহীন",
//       "cover": "https://i.postimg.cc/nzfjLC4m/Charitraheen.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cae"
//       }
//     }
//   ],
//   "__v": 0
// },
// {
//   "_id": {
//     "$oid": "67c3dfeca0eaea993eae8caf"
//   },
//   "name": "কাজী নজরুল ইসলাম",
//   "books": [
//     {
//       "title": "বিবের বাঁশী",
//       "cover": "https://i.postimg.cc/8zgJt7jC/bisher-bashi.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cb0"
//       }
//     },
//     {
//       "title": "বাঁধন-হারা",
//       "cover": "https://i.postimg.cc/yxSh32rp/Bandhan-Hara.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cb1"
//       }
//     },
//     {
//       "title": "মৃত্যুক্ষুধা",
//       "cover": "https://i.postimg.cc/d3qBp5W5/Mrityukshuda.jpg",
//       "_id": {
//         "$oid": "67c3dfeca0eaea993eae8cb2"
//       }
//     }
//   ],
//   "__v": 0
// },
// {
//   "_id": {
//     "$oid": "67c3e028a0eaea993eae8cc2"
//   },
//   "name": "ajju sexy",
//   "books": [
//     {
//       "title": "das",
//       "cover": "https://i.postimg.cc/mrMbKJG7/himu.jpg",
//       "_id": {
//         "$oid": "67c3e043a0eaea993eae8cd0"
//       }
//     },
//     {
//       "title": "jgfghfgh",
//       "cover": "https://i.postimg.cc/sDv1wn14/nondiko-noroke.jpg",
//       "_id": {
//         "$oid": "67c3e1cfa0eaea993eae8cf9"
//       }
//     },
//     {
//       "title": "dsfdsfsssssssssssssss",
//       "cover": "https://yt3.ggpht.com/KVjptxDSWT7rjVfGax2TgTNVAYgplgo1z_fwaV3MFjPpcmNVZC0TIgQV030BPJ0ybCP3_Fz-2w=s88-c-k-c0x00ffffff-no-rj",
//       "_id": {
//         "$oid": "67c3e669a0eaea993eae8d6d"
//       }
//     },
//     {
//       "title": "gfgddg",
//       "cover": "https://fonts.gstatic.com/s/e/notoemoji/15.1/1f601/72.png",
//       "_id": {
//         "$oid": "67c3e71ba0eaea993eae8db4"
//       }
//     }
//   ],
//   "__v": 4
// },
// {
//   "_id": {
//     "$oid": "67c3e764a0eaea993eae8dee"
//   },
//   "name": "ajju bhai sexy",
//   "books": [],
//   "__v": 0
// }]