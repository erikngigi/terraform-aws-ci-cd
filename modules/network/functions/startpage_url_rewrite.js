function handler(event) {
  var request = event.request;
  var uri = request.uri;

  // Root path → index.html
  if (uri === "/") {
    request.uri = "/index.html";
  }
  // Directory-style URL → append index.html
  else if (uri.endsWith("/")) {
    request.uri += "index.html";
  }
  // Path without file extension → treat as folder
  else if (!uri.includes(".")) {
    request.uri += "/index.html";
  }

  return request;
}
