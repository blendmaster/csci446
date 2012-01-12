(function () {
//html5 validity api all up ins
var validate = function () { 
	this.setCustomValidity((this.validity.valueMissing) ? this.dataset.errorMessage : "");
};
var feel = document.getElementById('feel')['current-feel'];
feel.addEventListener('input', validate);
feel.addEventListener('invalid', validate);

//prevent form submission (page reload)
document.getElementById('feel').addEventListener('submit', function(e) { e.preventDefault(); });
})();