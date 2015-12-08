// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
 $('a.edit_post_link').click(function(){
    var post_id = $(this).data('postId');
    var form = $('#edit_post_' + post_id);
    var title = $('#post_' + post_id);
    
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
