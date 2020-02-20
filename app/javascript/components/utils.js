$(document).ready(function () {
  $('.button-delete').click(function () {
    if ($(this).attr('modal-element-title')){
      $('#modal-body-title').text($(this).attr('modal-element-title'));
    }
    $('#modal-body-element').text($(this).attr('modal-element'));
    $('#modal-body-hint').text($(this).attr('modal-hint'));

    $('#modal-footer-button').attr('href', $(this).attr('modal-url'));
    $('#modal-1').modal('show');
  });
})
