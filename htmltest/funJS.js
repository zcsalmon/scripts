$(document).ready(function() {

    $("#menuButton").click(function () {
        /*
            if ("#left_bar".style.display == "block") {
                $("#left_bar").slideUp(700);
                $("#left_bar").css("display", "none")
                $("#sidebar").css("display", "none")
                $("#sidebar").children().css("display", "none")


            } else {
                $("#left_bar").slideDown(700);
                $("#left_bar").css("display", "block")
                $("#sidebar").css("display", "block")
                $("#left_bar").children().css("display", "block")

        */
        
        if ("#left_bar".style.display == "block") {
            $("#left_bar").slideUp(700);
            $("#left_bar").css("display", "none")
            $("#sidebar").css("display", "none")
            $("#sidebar").children().css("display", "none")


        } else {
            $("#left_bar").slideDown(700);
            $("#left_bar").css("display", "block")
            $("#sidebar").css("display", "block")
            $("#left_bar").children().css("display", "block")
        
        
        
        

            }
        });
});