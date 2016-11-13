$(document).ready(showImage);

function showImage () {
  $(".with").click(function() {
    $(".show-image").css("display", "block");
    $(".chang-img").replaceWith($(this).clone());
    $(".show-image").css("margin-top", $(window).scrollTop());
  });

  $(document).mouseup(function(e) {
    if (!$(".large-image").is(e.target) && $(".large-image").has(e.target).length === 0) {
      $(".show-image").css("display", "none");
      $(".large-image").html("");
      $("<img src='' class='chang-img' >").appendTo($(".large-image"));
    }
  })
}
