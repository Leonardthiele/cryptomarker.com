import $ from "jquery";
var timeago = require('timeago')

$(document).ready(function () {
  $("time.timeago").timeago();
});
