##How to setup project

### Compile war for Web Container:

define your PATH_TO_JAVAX_SERVLET_API (javax.servlet-api-3.1.0.jar)

`ocamljava -cp $PATH_TO_JAVAX_SERVLET_API -I +javalib javalib.cmja -java-extensions -servlet http server.ml`
`ocamljava -cp $PATH_TO_JAVAX_SERVLET_API -I +javalib javalib.cmja  -o server.war -war web.xml -servlet http server.cmj`

### Compile main 

`ocamljava str.cmja dir.ml -o count-lines.jar main.ml && java -jar count-lines.jar`