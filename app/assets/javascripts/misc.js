//Include helper functions here

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function testAlert(name) {
  alert("."+name);
};