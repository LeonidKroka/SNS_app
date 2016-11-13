$(document).ready(createPostAction);
$(document).ready(createCommentAction);
$(document).ready(toCreateCommentAction);
$(document).ready(addHeightToProfile);
$(document).ready(sendMessadge);

function createPostAction () {
  $(".new-post").click(function() {
    $(".to-create-post").css("display", "none");
    $(".create-post").css("display", "block");
    $(".post-create-body").focus();
  });

  $(document).mouseup(function(e) {
    if (!$(".create-post").is(e.target) && $(".create-post").has(e.target).length === 0) {
      $(".to-create-post").css("display", "block");
      $(".create-post").css("display", "none");
    }
  })
}

function createCommentAction () {
  var id='0';
  $(".new-comment").click(function() {
    id=this.id;
    $(".to-create-comment-"+id).css("display", "none");
    $(".create-comment-"+id).css("display", "block");
    $(".comment-create-body"+id).focus();
  });

  $(document).mouseup(function(e) {
    if (!$(".create-comment-"+id).is(e.target) && $(".create-comment-"+id).has(e.target).length === 0) {
      $(".to-create-comment-"+id).css("display", "block");
      $(".create-comment-"+id).css("display", "none");
    }
  });
}

function toCreateCommentAction () {
  var id='0';
  $(".to-comment").click(function() {
    id=this.id;
    $(".create-comment-"+id).css("display", "block");
    $(".comment-create-body").focus();
  });

  $(document).mouseup(function(e) {
    if (!$(".create-comment-"+id).is(e.target) && $(".create-comment-"+id).has(e.target).length === 0) {
      $(".create-comment-"+id).css("display", "none");
    }
  });
}

function addHeightToProfile () {
  $(".user-show").css("min-height", 30+$('.profile-static').height());
}

function sendMessadge () {
  $(".send-letter").click(function() {
    $(".send-messadge").css("display", "block");
    $(".messadge-create-body").focus();
  });

  $(document).mouseup(function(e) {
    if (!$(".send-messadge").is(e.target) && $(".send-messadge").has(e.target).length === 0) {
      $(".send-messadge").css("display", "none");
    }
  });
}
