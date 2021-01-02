$(function(){
  $('#follow-link').on('click', function(){
    $('.follow-modal').fadeIn();
  });
  $('.follow-modal-close').on('click', function(){
    $('.follow-modal').fadeOut();
  });
});

$(function(){
  $('#follower-link').on('click', function(){
    $('.follower-modal').fadeIn();
  });
  $('.follower-modal-close').on('click', function(){
    $('.follower-modal').fadeOut();
  });
});
