type t = unit

let init _ = ()

include JavaServlet.Default_HTTP

let print out s =
  Java.call "javax.servlet.ServletOutputStream.println(String)"
    out
    (JavaString.of_string s)

let get req s =
  Java.call "javax.servlet.ServletRequest.getParameter(String)"
    req
    (JavaString.of_string s)
  |> Java.wrap

let do_get _ _ req resp =
  Java.call "javax.servlet.http.HttpServletResponse.setContentType(_)"
    resp
    (JavaString.of_string "text/html");
  let out = Java.call "javax.servlet.http.HttpServletResponse.getOutputStream()" resp in
  print out "<html>";
  print out "  <body>";

  begin match get req "name" with
    | Some name ->
      print out (Printf.sprintf "    Hi %s!<br>" (JavaString.to_string name))
    | None ->
      print out "    Hi!<br>"
  end;
  print out "    <form action=\"hello\" method=\"get\">";
  print out "      <input type=\"text\" name=\"name\">";
  print out "      <input type=\"submit\" value=\"go\"><br>";
  print out "    </form>";
  print out "  </body>";
  print out "</html>"

let do_options _ _ _ resp =
  JavaServlet.options resp [`GET; `OPTIONS]
