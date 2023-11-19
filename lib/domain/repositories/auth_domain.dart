abstract class IAuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password, String name, String phone, String country);
  Future<void> signOut();
  Future<String> getMessagingToken(); 
}