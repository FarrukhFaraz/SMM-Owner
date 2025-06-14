String mainURL = "https://smmowner.shop/";
String baseApiUrl = "${_getAPIURL(mainURL)}/api";
String baseMediaUrl = _getMediaURL(mainURL);

String _getMediaURL(String url) {
  if (url.endsWith('/')) {
    return url.substring(0, url.length - 1);
  }
  return url;
}

String _getAPIURL(String url) {
  return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
}
