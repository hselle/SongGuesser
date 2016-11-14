var box = document.querySelector(".alert-box");

function removeDelay(){
	box.classList.remove("fade-out-delay");
}

if(box != null){
	document.querySelector(".ion-ios-close-empty").onclick = removeDelay;
	setTimeout(function(){ box.parentNode.removeChild(box); }, 6000);
}else{
	console.log("No flash message!");
}
;
