$(document).ready(function(){
      $('.js-menu li a.waves-effect').off('click').on('click', function(e){
            console.log('kjsdjj');
            e.preventDefault();
      })
      $('.task .js-add-task input').off().on('click', function(){
        var task_type = $(this).closest('.js-add-task').data('type');
      	$(this).closest('.js-add-task').toggleClass('active');

        if ($(this).closest('.js-add-task').hasClass('active')){
        	$.ajax({
        		url: window.location.pathname + '/tasks/new',
        		data: {type: task_type},
                        datatype: 'html', 
        		success: createChoice(task_type),
        		error: function (error){
        			console.log(error.responseText);
        		}
        	})
        } else {
          $('.choiceForm#'+task_type).empty();
        }
      })
      function createChoice (type) {
          return function (data){
              $('.choiceForm#'+type).html(data);
              $('.collapsible li#'+type).show();
            }
      }
      // Initialize collapse button
  $(".button-collapse").sideNav();
  // Initialize collapsible (uncomment the line below if you use the dropdown variation)
  //$('.collapsible').collapsible();
  $('.button-collapse').sideNav('show');
  $('.modal').modal();
  $('.option').on('change', function(e) {
    computeTotal();
  });

  function computeTotal() {
    var total = 0;
    $('.option:checked').each(function(idx, option) {
      var price = parseFloat(
        $("#" + option.id + "-price").text().split("€")[0]
      );

      if (price) {
        total += price;
      }
    });

    $('#total-price').text(total);
  }

  $('#js-send-options').on('click', function(){
      var options = []
      var option_elements = $('input:checked');
      option_elements.each(function(){
        options.push($(this).val())
      })
        $.ajax({
              method: 'post',
              url:'/events/save_options',
              data: {options: options},
              datatype: 'json', 
              success: function(){
                  Materialize.toast('Evento enviado correctamente!', 3000, 'rounded')
              },
              error: function (error){
                      console.log(error.responseText);
              }
        })
  })
  $('.choiceForm').on('click', 'form#new_choice button', function(e){
    e.preventDefault()
      var option_type = $(this).attr('id');
      var form = $(this).closest("form");
      var name = form.find('input[name=name]').val();
      var url = form.find('input[name=url]').val();
      var price = form.find('input[name=price]').val();
        $.ajax({
              method: 'post',
              url: form.attr('action'),
              data: {choice: {name: name, url: url, price: price}},
              datatype: 'html', 
              success: function(data){
                  Materialize.toast('Opcion añadida correctamente!', 3000, 'rounded')
                  $('li#'+option_type+' .collapsible-body').append(data)
              },
              error: function (error){
                      console.log(error.responseText);
              }
         })
      })
  $('ul.tabs').tabs();
})