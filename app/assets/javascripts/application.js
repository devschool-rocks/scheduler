// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require local_time
//= require handlebars-1.0.rc.1.min
//= require jstz.min
//= require moment.min
//= require moment-timezone-with-data-2010-2020
//= require_tree .

$(document).ready(function() {
  $("a[rel=popover]").popover();
  $(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();

  var currentUserId = parseInt($("#currentUserId").html()) > 0;
  var timezone = jstz.determine();

  $("body").on("click", "#agenda .hour.available", function(e) {
    var startAt = $(e.currentTarget).html().trim();
    var startOn = $("#selectedDate").html().trim();
    var suggestion = moment(startOn + ' ' + startAt, "MMMM Do YYYY hh:mm a").toDate()
    var formattedDate = new Date(suggestion);
    if (currentUserId) {
      bookIt = $("#bookSlotModal");
      bookIt.find("#selectedTime").html(startAt);
      bookIt.find("#selectedDate").html(startOn);
      bookIt.find("#appointment_start_at").val(formattedDate);
      bookIt.modal();
    } else {
      $("#loginModal").modal();
    }
  });

  $("#calendar .day.today, #calendar .day.future").on("click", function(e) {
    var date = $(this).data("date");
    var context = $.ajax({
      type: 'GET',
      url: '/agenda/'+date,
      dataType: 'json',
      async: false
    }).responseJSON;
    var source   = $("#hour-template").html();
    var template = Handlebars.compile(source);
    var html     = template(context);
    $("#agendaModal #agenda").html(html);
    $("#agendaModal #selectedDate").html(moment(date).format("MMMM Do YYYY"));
    $("#agendaModal").modal();
  });
});
