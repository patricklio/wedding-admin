$(document).ready(function () {
  $('.button-delete').click(function () {
    $('#modal-body-element').text($(this).attr('modal-element'));
    $('#modal-footer-button').attr('href', $(this).attr('modal-url'));
    $('#modal-1').modal('show');
  });
})