class MyAPIUtil {
  static String MyApiPosts = "wp-json/wp/v2/posts";
  static String myWebSite = "https://www.maroc24.com";
  static String perPage = '&per_page=10';
  static Map<String, String> myHeaders = {"Accept": "application/json"};
  static String myComments = myWebSite + '/' + "wp-json/wp/v2/comments?post=";
  static String myCatAll = "/wp-json/wp/v2/categories";
  static String myAuthorAPI = "wp-json/wp/v2/users/";

  ///This is for searching and it require
  static String searchAPI = "/wp-json/wp/v2/posts?search=";

  ///it require author_name,content,post and parent
  static String addCommentAPI =
      "/wp-json/wp/v2/comments?author_email=app@maroc24.com";

  static const String ReloadCommentsAPIFirebase =
      "https://maro24.web.app/api/updateTheComments/";

  static const String getPostsPerPage =
      "https://maro24.web.app/api/orgnizePerPage?pageNumber=";
}
