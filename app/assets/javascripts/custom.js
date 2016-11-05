function createOption(value, display){
  return '<option value="' + value + '">' + display + '</option>';
}

$(document).on('turbolinks:load', function(){
  $('#classify_filter').change(function(){
    var value = $(this).val();
    var url = $(this).attr('data-url');
    $.ajax({
      url: url,
      data: {classify: value},
      success: function(data){
        var first_option = $('#category_id_filter option').first();
        var options = createOption(first_option.attr('value'), first_option.text());
        $.each(data, function(index, category){
          options += createOption(category.id, category.name);
        });
        $('#category_id_filter').html(options);
      }
    });
  });
});
