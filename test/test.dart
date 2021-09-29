import 'package:flutter_test/flutter_test.dart';
import 'package:waco_mobile/pages/login_page.dart';
import 'package:waco_mobile/providers/user_likes_provider.dart';

void main() {
  test(
      'Provider user_likes_provider recieve not registered uid returns an exception',
      () {
    var result = UserLikesProvider.getLikes('Wrong uid');
    expect(result, throwsException);
  });

  test('Password short lenght returns a message', () {
    var result = Validator.validatePassword('short');
    expect(result, 'La contraseña debe tener al menos 6 caracteres');
  });

  test('Password or email empty returns message', () {
    var resultP = Validator.validatePassword('');
    var resultE = Validator.validateEmail('');
    expect(resultP, 'El campo no debe estar vacío');
    expect(resultE, 'El campo no debe estar vacío');
  });

  test('Wrong email sintax returns message', () {
    List<String> wrongEmails = [
      'wac',
      'wacoservices',
      'wacoservices@',
      'wacoservices@gmail',
    ];

    for (String email in wrongEmails) {
      var result = Validator.validateEmail(email);

      expect(result, 'Dirección de correo invalida');
    }
  });

  test('Good email sintax returns empty message', () {
    List<String> writeEmails = [
      'wacoservices@gmail.com',
      'martinale4@hotmail.com',
      'juanpari1766@gmail.com',
      'actora_nzi457@nodemailer.es',
    ];

    for (String email in writeEmails) {
      var result = Validator.validateEmail(email);

      expect(result.isEmpty, true);
    }
  });

  test('long passwords return empty message', () {
    List<String> writePasswords = [
      'Wacoservice123',
      '123456',
      'contraseña',
    ];

    for (String password in writePasswords) {
      var result = Validator.validatePassword(password);

      expect(result.isEmpty, true);
    }
  });
}
