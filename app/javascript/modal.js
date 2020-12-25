$(function(){
const menu = document.getElementById('img-menu-icon');
$('#img-menu-icon').on('click', function(){
  if (menu.getAttribute("class") != "open-menu") {
    $('#modal-menu').fadeIn();
    $('#img-menu-icon').addClass("open-menu");
  } else {
    $('#modal-menu').fadeOut();
    $('#img-menu-icon').removeClass("open-menu");
  }
});
});