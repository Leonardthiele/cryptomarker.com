import $ from "jquery";

$(function () {
  console.log('helper')

  $('form').on('click', '.add_fields', function(event) {
    console.log('jo');
    let time = new Date().getTime();
    let regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  })

});

