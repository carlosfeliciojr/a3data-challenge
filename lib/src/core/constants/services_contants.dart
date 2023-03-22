class ServicesConstants {
  const ServicesConstants._();

  static const domain = "https://api.github.com";
  static const searchRepositoryEndPoint =
      "$domain/search/repositories?q=language:{0}&sort=stars&order=desc&page={1}&per_page={2}";
  static const getUserRepositories = "$domain/users/{0}/repos";
}
