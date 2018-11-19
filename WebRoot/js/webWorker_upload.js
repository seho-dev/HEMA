self.onmessage = function(event) {
	var size = 2*1024*1024;

	var file = event.data; 
	var fileSize = file.size;
	var fileName = file.name;
	var chuckSize = Math.ceil(fileSize/size);
	  
	var form = new FormData();
	form.append("fileName", fileName);       //fileName     
	var xhr = new XMLHttpRequest();
	xhr.open("post", "/cardgroup!uploadFileStatus", true);
	xhr.timeout = 5000;
	xhr.responseType = "text";
	xhr.onload = function () {
	    if(this.status == 200||this.status == 304){
	        var JSONObj = eval("("+this.responseText+")");
		     
	        var i = JSONObj.result; 
		       self.postMessage(i/chuckSize);
	
		  	  for(i;i<chuckSize;i++){
				  var blob = file.slice(size*i,size*(i+1));  
				  upload(blob,fileName,fileSize,chuckSize,i+1);
			  }
	
	    }
	    if(this.status == 404 ||this.status == 500){
	        self.postMessage("error");
	    }
	};
	xhr.ontimeout = function(e) { 
		self.postMessage("error");
	};
	xhr.onerror = function(e) { 
		self.postMessage("error");
	};
	xhr.upload.onprogress = function(e) {
	};
	
	xhr.send(form);
 
};

 
function upload(blob,fileName,fileSize,chuckSize,currentChuck){
	var form = new FormData();
	form.append("file", blob);       //data                   
	form.append("fileName", fileName);       //fileName     
	form.append("fileSize", fileSize);       //fileSize     
	form.append("chuckSize", chuckSize);       //chuckSize                   
	form.append("currentChuck", currentChuck);       //currentChuck                   

	var xhr = new XMLHttpRequest();
	xhr.open("post", "/cardgroup!uploadChuckFile", false);
	xhr.onload = function () {
	    if(this.status == 200||this.status == 304){
	    	try{
		        var JSONObj = eval("("+this.responseText+")");
		        var result = JSONObj.T;
		        if(result == "S"){
			        self.postMessage(currentChuck/chuckSize);
		        }else{
			        self.postMessage("error");
		        }
	    	}catch(e){
		        self.postMessage("error");
	    	}
	    }
	    if(this.status == 404 ||this.status == 500){
	        self.postMessage("error");
	    }
	};
	xhr.ontimeout = function(e) { 
		self.postMessage("timeout");
	};
	xhr.onerror = function(e) { 
		self.postMessage("error");
	};
	xhr.upload.onprogress = function(e) {
		//console.log(e);
	};
	
	xhr.send(form);
	
}


    