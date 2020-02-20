$(document).ready(function () {
  $('.grid .clickable').on('click', function () {
    var el = jQuery(this).parents(".grid").children(".grid-body");
    el.slideToggle(200);
  });
});
