import 'package:supabase_functions/supabase_functions.dart';

void main() {
  SupabaseFunctions(
    fetch: (request) async {
      // 1. Get audio URL and target text from request
      // 2. Download audio from Storage
      // 3. Send to Google Cloud Speech-to-Text
      // 4. Compare transcript with target text (Levenshtein distance, etc)
      // 5. Return Score + Transcript
      
      return Response.json({
          'transcript': 'Hello world',
          'score': 95.5
      });
    },
  );
}
