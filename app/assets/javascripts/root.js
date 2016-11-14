$(document).ready(rootJSAction);

function rootJSAction () {
  $(".dropdown").click(function() {
    $(this).css("border", "1px solid #ccc");
    $(this).css("background-color", "rgba(12, 85, 140, 0.3)");
    $(".dropdown-menu").css("display", "block");
    $(".dropdown-up").css("display", "block");
  })

  $(document).mouseup(function(e) {
    if (!$(".dropdown-menu").is(e.target) && $(".dropdown-menu").has(e.target).length === 0) {
      $(".dropdown").css("border", "0px");
      $(".dropdown").css("background-color", "rgba(0, 0, 0, 0)");
      $(".dropdown-menu").css("display", "none");
      $(".dropdown-up").css("display", "none");
    }
  })

  $(window).scroll(function() {
    var heightToBottom = $( document ).height()-$(window).scrollTop()-$( window ).height();
    if ($(window).scrollTop() > 20 & heightToBottom > 45) {
      $(".go-up").css("margin-top", $(window).scrollTop()+$( window ).height()-15);
      $(".go-up").css("display", "block");
    }
    else if ($(window).scrollTop() > 20) {
      $(".go-up").css("margin-top", $(window).scrollTop()+$( window ).height()-45);
      $(".go-up").css("display", "block");
    }
    else {
      $(".go-up").css("display", "none");
    }
  })

  $(".go-up").click(function() {
    $(window).scrollTop( 0 )
  })
}
