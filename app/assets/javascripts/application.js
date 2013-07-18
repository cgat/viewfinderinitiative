// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.classycompare
//= require_tree .

$('document').ready(function() {
  //This will allow a smooth scroll for anchor tag with the scroll class (http://www.sycha.com/jquery-smooth-scrolling-internal-anchor-links)
  $(".scroll").click(function(event){
    event.preventDefault();
    $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
  });

  // display validation errors for the "request invitation" form
  if ($('.alert-error').length > 0) {
    $("#request-invite").modal('toggle');
  }

  // use Ajax to submit the "request invitation" form
  $('#invitation_button').on('click', function() {
    var email = $('form #user_email').val();
    var dataString = 'user[email]='+ email;
    $.ajax({
      type: "POST",
      url: "/users",
      data: dataString,
      success: function(data) {
        $('#request-invite').html(data);
        loadSocial();
      }
    });
    return false;
  });

});

// load social sharing scripts if the page includes a Twitter "share" button
function loadSocial() {

    //Twitter
    if (typeof (twttr) != 'undefined') {
      twttr.widgets.load();
    } else {
      $.getScript('http://platform.twitter.com/widgets.js');
    }

    //Facebook
    if (typeof (FB) != 'undefined') {
      FB.init({ status: true, cookie: true, xfbml: true });
    } else {
      $.getScript("http://connect.facebook.net/en_US/all.js#xfbml=1", function () {
        FB.init({ status: true, cookie: true, xfbml: true });
      });
    }

    //Google+
    if (typeof (gapi) != 'undefined') {
      $(".g-plusone").each(function () {
        gapi.plusone.render($(this).get(0));
      });
    } else {
      $.getScript('https://apis.google.com/js/plusone.js');
    }
}

function adjust_before_after(width) {
  old_bg_width  = $('.comparison_before_after').width();
  $('.comparison_before_after').css("width",width);
  change_factor = old_bg_width/$('.comparison_before_after').width();
  $('.comparison_before_after').css("height",$('.comparison_before_after').height()/change_factor);
  $('.uc-bg').css('width',$('.comparison_before_after').width());
  $('.uc-bg').css('height',$('.comparison_before_after').height());
  $('.uc-bg').css('background-size',$('.comparison_before_after').width());
  $('.uc-mask').css('background-size',$('.comparison_before_after').width());
  $('.uc-mask').css('width',$('.uc-mask').width()/change_factor);
  $('.uc-mask').css('height',$('.comparison_before_after').height());
}
$(window).resize(function(){
  adjust_before_after($(window).width());
})
$(window).load(function() {
    $('.comparison_before_after').ClassyCompare({
        defaultgap: 200,
        leftgap: 10,
        rightgap: 10,
        caption: false,
        reveal: 0.5
    });
    adjust_before_after($(window).width());
});
