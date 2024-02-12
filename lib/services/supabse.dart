import '../main.dart';

class Supabase {
  void fetchData() async {
    final response = await supabase.from('users').select().select();
    print(response);
  }
}
