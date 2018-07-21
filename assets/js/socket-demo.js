import socket from "./socket"
import notify from './notifications'
import $ from "jquery";

console.log('Socket demo');

let channel = socket.channel("exchange:2", {}) //

channel.join()
  .receive("ok", resp => { console.log("Joined exchange notifications successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("drop", (payload) => {
  console.log("got a notification drop event", payload)
  // notify(payload);
})

$(function () {
  $('#socket_test').on('click', function(event) {
    console.log('send test event')
    $.get(location.href, {})
    event.preventDefault();
  })

})
