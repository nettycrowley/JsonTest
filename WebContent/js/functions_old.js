
function init() {
	//	create an object
	var o = {};
	
	//	assign some values
	o.value = 1;
	o.suit = 1;
	
	//	assign a function
	o.display = function() {
		console.log("this is a card(" + 
					 this.value + "," + this.suit + ")");
	}
	
	o.toString = function() {
		var c = "";
		switch(this.value) {
		case 1:
			c = " A";
			break;
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			c = " " + this.value;
			break;
		case 10:
			c = this.value;
			break;
		case 11:
			c = " J";
			break;
		case 12:
			c = " Q";
			break;
		case 13:
			c = " K";
			break;
		default:
			c = "  ?";
			break;
		}
		
		switch(this.suit) {
		case 1:
			c = c + "H";
			break;
		case 2:
			c = c + "S";
			break;
		case 3:
			c = c + "C";
			break;
		case 4:
			c = c + "D";
			break;
		default:
			c = c + "?";
			break;
				
		}
		return c;
		
		
	}
	
	//	call a function
	o.display();
	
	console.log(o.toString());

	alert (JSON.stringify(o));
	
	console.log(JSON.stringify(o));
	
	var s = "{\"field1\":\"value1\", \"field2\":\"value2\"}";
	
	var fobject = JSON.parse(s);
	
	console.log(fobject.field1);
	console.log(fobject.field2);
	
	var list = ["one", "two", "three", "four"];
	
	
	var deck = {"cards":[{"value":1,"suit":1}, {"value":2,"suit":1} ]};
	
	
	
	
	
	
	
	
	
	
	
	console.log(JSON.stringify(list));
	
	
	//{"value":1,"suit":1}
	
}

function getJson() {
	
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("resultDiv").innerHTML = this.responseText;
            
            //	convert json to a javascript object
            var deck = JSON.parse(this.responseText);
            
        	alert("got the deck:" + deck.field1);
        }
    };
	
	xhr.open("GET", "getDeck.jsp", true);
	
	xhr.send();
	
	
}
function getUser() {
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("resultDiv").innerHTML = this.responseText;
            
            //	convert json to a javascript object
            var user = JSON.parse(this.responseText);
            
        	alert("got the user:" + 
        		  user.firstName + " " + user.lastName);
        }
    };
	
	xhr.open("GET", "getUser.jsp", true);
	
	xhr.send();
	
}

var users;

function getUsers() {
	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            //document.getElementById("resultDiv").innerHTML = this.responseText;
            
            //	convert json to a javascript object
            users = JSON.parse(this.responseText);

        	var select = document.getElementById("userList");

        	//	remove elements from select box
        	while (select.length > 0) {
        		select.remove(0);
        	}
        	
            for (i=0; i<users.length; i++) {
            	
            	var option = document.createElement("option");
            	option.text = users[i].firstName + " " + users[i].lastName;
            	option.value = i;
            	select.add(option);
            }
            //	show the first user
            showUser(0);
        }
    };
	
	xhr.open("GET", "getUsers.jsp", true);
	
	xhr.send();
	
}

function selectUser() {
	
	var select = document.getElementById("userList");
	showUser(select.value);
}

function showUser(i) {

	var user = users[i];
	document.getElementById("id").value = user.id;
	document.getElementById("firstName").value = user.firstName;
	document.getElementById("lastName").value = user.lastName;
	document.getElementById("registered").checked = user.registered;
	document.getElementById("dateOfBirth").value = user.dateOfBirth;
}






