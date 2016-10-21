// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require html5imageupload.min
//= require_tree .

$(document).ready(function() {
  var screenId = 1;

  $('.left').click(function() {
    screenId--;

    if(screenId == 1){
      $('.left').hide();
    }
    else{
      $('.left').show();
      $('.right').show();
    }
    updateScreens();
  });

  $('.right').click(function() {
    screenId++;

    if(screenId == 4){
      $('.right').hide();
    }
    else{
      $('.left').show();
      $('.right').show();
    }
    updateScreens();
  });

  function updateScreens() {
    $('.img-overlay-container').hide();
    $("#" + screenId).show();
  }

  $('.order-mug').click(function() {
    screenId = 3;
    $('.left').show();
    $('.right').show();
    updateScreens();
  });

  $('#get-inspired').click(function() {
    screenId = 2;
    $('.left').show();
    $('.right').show();
    updateScreens();
  });

  // **** Dropzone setup *****
  $('.dropzone').html5imageupload({
    onAfterInitImage: function() {
      addClickHandlerToDelete()
      $(".dropzone.round img, .dropzone.round canvas").css("border-radius", "50%");
  	},
    onAfterProcessImage: function() {
      addClickHandlerToDelete();
      addClickHandlerToEdit();
      $(".dropzone.round img, .dropzone.round canvas").css("border-radius", "50%");
      $(".dropzone").removeClass("new");
      $('.dropzone').css('overflow', 'hidden');
  	}
  });

  // Need to do this because onAfterRemoveImage doesn't work as advertised
  function addClickHandlerToDelete() {
    console.log("HIT1");
    $('.btn-del').click(function(){
      $(".dropzone").addClass("new");
      $('.dropzone').css('overflow', 'visible');
    });
  }
  function addClickHandlerToEdit() {
    console.log("HIT2");
    $('.btn-edit').click(function(){
      $(".dropzone.round canvas, .dropzone.round img, .cropWrapper.round img").css("border-radius", "0");
      $('.dropzone').css('overflow', 'visible');
    });
  }
});
