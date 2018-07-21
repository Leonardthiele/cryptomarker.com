import $ from "jquery";
import Headroom from "headroom.js/dist/headroom.min";

$(document).ready(function () {
  $("[data-headroom-top]").each(function (_element) {
    let headroom = new Headroom(this, {
      tolerance: 5
    });
    headroom.init();
  });
});
