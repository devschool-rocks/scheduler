Handlebars.registerHelper('localTime', function(timestamp) {
  var d = new Date(timestamp);
  return LocalTime.strftime(d, "%l:00 %P");
});
