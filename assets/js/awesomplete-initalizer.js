import $ from "jquery";
import "awesomplete";


$(document).ready(function () {
  $("#currency-list").each(function(elem) {
    $.get("/api/currencies", function (currencies) {
      var list = currencies.map((currency) => {
        return {
          value: currency.id,
          label: '<img height="16" width="16" src="' + currency.logo + '"> ' + currency.name
        }
      });
      let aaa = new Awesomplete(document.querySelector("#currency-list"), {
        list: list,
        minChars: 1,
        autoFirst: true,
        sort: false,
        fiter: Awesomplete.FILTER_STARTSWITH
      });

      document.getElementById('currency-list').addEventListener("awesomplete-select", function (event) {
        event.preventDefault();
        window.location.href = "/currencies/" + event.text.value;
      });
    });
  });
});
