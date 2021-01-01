$(window).on("scroll", function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop(); //現在地 
  footHeight = $("footer").innerHeight(); //止めたい位置の高さ(今回はfooter)
  if (scrollHeight - scrollPosition <= footHeight) { //ドキュメントの高さと現在地の差がfooterの高さ以下の時
    $(".submit-article-btn").css({
        "position": "absolute",
        "bottom": "0",
        "left": "0",
    });
} else {
    $(".submit-article-btn").css({
        "position": "fixed",
        "bottom": "20px",
        "left": "10vw",   
    });
}
});