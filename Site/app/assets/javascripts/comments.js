// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
 $('a.edit_comment_link').click(function(){
    var comment_id = $(this).data('commentId');
    var form = $('#edit_comment_' + comment_id);
    var title = $('#comment_' + comment_id);
    
    if ($(this).hasClass('cancel')){
      $(this).html('Edit');
      $(this).removeClass('cancel');  
    } else {
      $(this).html('Cancel');
      $(this).addClass('cancel');  
    }


    form.toggle();
    title.toggle();
  });

});