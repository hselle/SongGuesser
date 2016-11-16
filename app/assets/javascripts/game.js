$(document).on('turbolinks:load', function() {
    /** 
		Uncle Tom's duties - 
		Auto-play the audio after 5 seconds
  		Keep track of the position of the audio and display it on status bar
    	On-end wait for 10 seconds and send whatever you have to the server
	**/
    var uncletom = document.getElementById("uncletom");
    var barbox = document.querySelector(".bar-box");
    var statusbtn = document.querySelector("#status-box i");


    /** submits the form to the server **/
    function sendResults() {
        document.getElementById("submit").click();
    }

    /** update the view witha  countdown **/
    function countDown(i) {
        barbox.innerHTML = "Automatically sending answer in .. " + i;

        if (i > 0) {
            setTimeout(function() {
                countDown(--i);
            }, 1000);
        } else {
            sendResults();
        }
    }

    /** update the button class **/
    function changeBtn(status) {
        if (status == 'play') {
            statusbtn.className = "icon ion-ios-play";
        } else if (status == 'stop') {
            statusbtn.className = "icon ion-stop";
        } else if (status == 'timer') {
            statusbtn.className = "icon ion-ios-stopwatch";
        }
    }
    /** 
    	handles the action after the audio player has stopped playing 
      tasks- a. update the view to countdown for 10 seconds
      			 b. send the results after 10 seconds
             c. Change the button to stop
    **/
    function uncleStopped() {
        changeBtn("timer");
        setTimeout(function() {
            countDown(10);
        }, 1000);
    }

    function updateTimer() {
        //get's the current timer and does a floor function to get the value
        //duration has a bug ->  " / " + uncletom.duration.toFixed(2)
        barbox.innerHTML = "Playing ... " + (uncletom.currentTime).toFixed(2) + " seconds";
    }

    function speakUncle() {
        changeBtn("play");
        uncletom.play();
        //show the button now
        document.querySelector(".game-btn").classList.remove("hide-me");
    }

    // Assign an ontimeupdate event to the <video> element, and execute a function if the current playback position has changed
    uncletom.ontimeupdate = function() {
        updateTimer()
    };
    uncletom.onended = uncleStopped;

    setTimeout(speakUncle, 3000);

});