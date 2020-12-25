$(function(){
  $('#search-image').on('click', function(){
    $('.search-modal').fadeIn();
  });
  $('.search-modal-close').on('click', function(){
    $('.search-modal').fadeOut();
  });
});
