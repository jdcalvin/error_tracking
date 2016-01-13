var autoResize = function() {
  var width = $('#content-panel').width();
  var textRescale = width / 42;
  var heightRescale = width * 0.16;
  var thResize = width * 0.025;
  
  $('.calendar tr').children('td').css({"font-size":textRescale+"px", "height":heightRescale+"px"});
  $('.calendar tr').children('th').css({"font-size":thResize+"px"});
  $('calendar').css({"height": heightRescale+"px"});
}