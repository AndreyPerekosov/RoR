$(document).ready(function(){
  // alert('Страница загружена'); - выдаем сообщние при загрузке страницы.
  //вешаем на класс edit_category_link событие, класс находится в ссылке поэтому a.edit_category_link 
  $('a.edit_category_link').click(function(){
    var category_id = $(this).data('categoryId'); //получаем из хэлпера номер категории по которой кликнули
    var form = $('#edit_category_' + category_id);
    var title = $('#category_' + category_id);
    
    if ($(this).hasClass('cancel')) {
      $(this).html('Edit');
      $(this).removeClass('cancel');
    } else {
      
      $('form.edit_category').hide();
      $('.edit_category_link.cancel').html('Edit');
      $('.category').show();

      $(this).html('Cancel');
      $(this).addClass('cancel');
    }

    form.toggle();
    title.toggle();
  });

});
