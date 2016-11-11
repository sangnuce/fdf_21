function createOption(value, display){
  return '<option value="' + value + '">' + display + '</option>';
}

function getCurrentDateTime(){
  var date = new Date();
  var day = date.getDate();
  var month = date.getMonth() + 1;
  var year = date.getFullYear();
  var hour = date.getHours();
  var minute = date.getMinutes();
  return day + '/' + month + '/' + year + ' ' + hour + '/' + minute;
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

  var datetimepicker_value = $('.datetimepicker_mark').attr('value');
  if(typeof datetimepicker_value == 'undefined'){
    datetimepicker_value = getCurrentDateTime();
  }
  $('.datetimepicker_mark').datetimepicker({
    format: 'd/m/Y H:i',
    value: datetimepicker_value,
    step: $('.datetimepicker_mark').attr('data-step'),
    minDate: $('.datetimepicker_mark').attr('data-min-date'),
  });
});
