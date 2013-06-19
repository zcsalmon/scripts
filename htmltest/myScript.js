var userChoice;
var computerChoice;
var FUCK = "FUCK ";
function dateDisplay(){document.getElementById("dateDisplay").innerHTML=Date();};
function shout() {
	document.getElementById("test").innerHTML=FUCK;
	FUCK += "FUCK "
};
lin = 1
function expand() {
    
    //document.getElementById("expand").style.lineHeight = lin + "00" + "%";
    document.getElementById("expand").style.size = "120px"
    
    
    //return document.getElementById("expand")
}


function compare(choice1, choice2) {
	if (choice1 == choice2) {
		alert("The result is a tie!");
	} else if (choice1 == "rock" && choice2 == "paper") {
		alert("paper wins");
	} else if (choice1 == "rock" && choice2 == "scissors") {
		alert("rock wins");
	}
	if (choice1 == "paper" && choice2 == "rock") {
		alert("paper wins");
	} else if (choice1 == "paper" && choice2 == "scissors") {
		alert("scissors wins");
	}
	if (choice1 == "scissors" && choice2 == "rock") {
		alert("rock wins");
	} else if (choice1 == "scissors" && choice2 == "paper") {
		alert("scissors wins");
	}
};

function populate() {
	userChoice = prompt("Do you choose rock, paper or scissors?");
	computerChoice = Math.random();
	if (computerChoice < 0.34) {
		computerChoice = "rock";
	} else if(computerChoice <= 0.67) {
		computerChoice = "paper";
	} else {
		computerChoice = "scissors";
}
	compare(userChoice, computerChoice);
};
//compare(userChoice, computerChoice);

$(document).ready(function() {

    $("#menuButton").click(function() {
        
            //if ("#left_bar".style.display == "block") {
                $("#left_bar").slideUp(700);
                
                //} else {
                //$("#left_bar").slideDown(700);
                //$("#left_bar").css("display", "block")
                //$("#sidebar").css("display", "block")
              //  $("#left_bar").children().css("display", "block")
            }
        });
});