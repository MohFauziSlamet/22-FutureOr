import 'dart:async';

void main(List<String> arguments) async {
  print('Hello world:!');

// dibawah ini cara membuat objek dari sebuah class
// type class = nama reference nya (nickname yang mengarah pada objek) = objek dari class User
  User user = User();

  UserManager userManager = UserManager(FirebaseStorage());
  UserManager userManager2 = UserManager(LocaLStorage());

  print(await userManager.getUserAge(user));
  print(await userManager2.getUserAge(user));
}

// form pengguna
class User {
  // user telated things
  // int age = 0;
}

//---------------------------------------------------------------------------------------------------
// high level modul
class UserManager {
  // IDataStorage adalah type, dataStorage adalahreference (nickname) . dart menyebutnya reference
  // IDataStorage didapat dari class IDataStorage
  final IDataStorage dataStorage;

  // constructor dari userManager
  UserManager(this.dataStorage);

  // methode/ perintah untuk menyimpan data user dari IDataStorage
  void saveUserData(User user) {
    dataStorage.saveData(user);
  }

  // userManager dapat mengembalikan nilai int maupun future<int>
  // userManager tidak perlu tau teknisnya bagaimana. apakah int atau future <int>
  // userManager langsung memberikan perintah FutureOr. baik int maupun future <int> dapat masuk
  // didalam methode FutureOr , tetap wajib mencantumkan methode async dan await.
  // karena userManager tidak tau , nanti yang masuk data bertipe int atau future.
  FutureOr<int> getUserAge(User user) async {
    return await dataStorage.getUserAge(user);
  }
}

//-----------------------------------------------------------------------
// core modul
// abstraction (kontrak) / interface
// abstract class tidak bisa dijadikan sebuah objek
//---
// pada class userManager , terdapat IDataStorage .IDataStorage tersebut dijadikan
// type oleh dataStorage. artinya dataStorage menunjuk pada IDataStorage.
// IDataStorage merupakan interface yang di implements oleh class FirebaseStorage dan LocaLStorage
// jadi IDataStorage pada class userManager menunjuk pada FirebaseStorage atau LocaLStorage
// tergantung pada kebutuhan sistemnya.

abstract class IDataStorage {
  // perintah untuk menyimpan data user
  void saveData(User user); // parameter user didapat dari kelas user

  // getUserAge dapat mengembalikan nilai int maupun future<int>
  // methode untuk menyambungkan ke datail (low level modul)
  // IDataStorage menerima data dari user
  FutureOr<int> getUserAge(User user); // parameter user didapat dari kelas user

}

//----------------------------------------------------------------------
// low level modul
// detail teknisnya
//
class FirebaseStorage implements IDataStorage {
  @override
  void saveData(User user) {
    //connect to firebase // mengambil data dari database
    // saveData
  }

  // getUserAge merupakan bahan yang harus didetailkan dari class IDataStorage
  // karena FirebaseStorage mengimplement IDataStorage, maka
  // semua methode yang ada di IDataStorage harus di override(wajib dimiliki oleh FirebaseStorage dan di detailkan)
  // karena data yang akan diambil nanti tidak jelas int apa future.
  // maka menggunakan FutureOr. ada dapat data yang masuk bisa int atau future
  @override
  FutureOr<int> getUserAge(User user) async {
    // mengambil data dari database
    await Future.delayed(Duration(seconds: 2));
    return 20;
  }
}

class LocaLStorage implements IDataStorage {
  @override
  void saveData(User user) {
    // connect to LocaLStorage
    // saveData
  }

  // getUserAge merupakan bahan yang harus didetailkan dari class IDataStorage
  // karena FirebaseStorage mengimplement IDataStorage, maka
  // semua methode yang ada di IDataStorage harus di override
  // (wajib dimiliki oleh FirebaseStorage dan di detailkan)
  @override
  int getUserAge(User user) {
    // mengambil data dari LocaLStorage
    // ambil data dari user
    // bandingkan tangal lahir dengan tanggal sekaran
    // lalu hitung umur user
    return 10;
  }
}
