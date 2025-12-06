class ApiUrl {
  static const String baseUrl = "http://192.168.56.1:8080"; 

  static const String login = baseUrl + "/login";
  static const String registrasi = baseUrl + "/registrasi";
  static const String listBarang = baseUrl + "/inventaris";
  static const String createBarang = baseUrl + "/inventaris";

  static String detailBarang(String id) {
    return baseUrl + '/inventaris/' + id;
  }

  static String updateBarang(String id) {
    return baseUrl + '/inventaris/' + id;
  }

  static String deleteBarang(String id) {
    return baseUrl + '/inventaris/' + id;
  }
}