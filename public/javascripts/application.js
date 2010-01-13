function human_size(bytes) {
  var s = ['bytes', 'kb', 'MB', 'GB', 'TB', 'PB'];
  var e = Math.floor(Math.log(bytes)/Math.log(1024));
  return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
}

$(document).ready(function(){

  // misc

  $('#user_login').focus();

  // new invitations form

  $("input#invitation_email").ezpz_hint();

  function newInvitationSubmit() {
    $("#new_invitation_status").html('<img src="/images/spinner1.gif" /></div>');
    $("#invitation_submit").attr("value", "sending...").attr("disabled", true)
  }

  function newInvitationSuccess() {
    $("#invitation_submit").attr("value", "send").attr("disabled", false)
  }

  $('#new_invitation').ajaxForm({
    target:'#new_invitation_status',beforeSubmit:newInvitationSubmit,success:newInvitationSuccess,clearForm:true,resetForm:true
  });

  // soundmanager

  var sm = soundManager;

  sm.url = '/flash';
  sm.flashVersion = 9;
  sm.debugMode = false;
  sm.useConsole = false;
  sm.useHighPerformance = true;
  sm.useMovieStar = true; // MP4/M4A/AAC

  sm.onready(function(){
    $('a.post').each(function(){
      $(this).makePlayable();
    });
  });

  $.fn.makePlayable = function(){
    $(this).addClass('playable');

    soundManager.createSound({
     id:$(this).attr('id'),
     url:$(this).attr('href'),
     onfinish:function(){
       $('#'+this.sID).parent().next().find('a.playable').play();
     }
    });

    $(this).click(function(e){
      e.preventDefault();
      $(this).play();
    });
  }

  $.fn.play = function(){
    if ($(this).hasClass('playing')){
      $(this).removeClass('playing');
      $(this).addClass('paused');
      sm.pause($(this).attr('id'));
      return;
    } if ($(this).hasClass('paused')){
      $(this).removeClass('paused');
      $(this).addClass('playing');
      sm.resume($(this).attr('id'));
      return;
    } else {
      sm.stopAll();
      $('.playing').removeClass('playing');
      $('.paused').removeClass('paused');
      $(this).addClass('playing');
      sm.play($(this).attr('id'));
      return;
    }
  }

});
