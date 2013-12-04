var express=require("express");
var app = express();
  
 /* serves main page */
 app.get("/", function(req, res) {
	     res.send("yup, i\'m a server");
 });
 
  app.post("/user/add", function(req, res) {
	      /* some server side logic */
	      res.send("OK");
	        });
 
/* serves all the static files */
app.get(/^(.+)$/, function(req, res){
	     console.log('static file request : ' + req.params);
	          res.sendfile( __dirname + req.params[0]);
});
 
var port = process.env.OPENSHIFT_DEBUG_MY_PORT || 5000;
var ip=process.env.OPENSHIFT_DEBUG_MY_IP || "127.0.0.1";
app.listen(port, ip,function() {
	   console.log("Listening on " + ip+":"+port);
});
