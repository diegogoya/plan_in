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
              //$('#talks-collapsibe').append(data);
              console.log(data)
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
      var option_type = $(this).attr('id')
      console.log(option_type)
        // $.ajax({
        //       method: 'post',
        //       url:'/events/save_options',
        //       data: {options: options},
        //       datatype: 'json', 
        //       success: function(){
        //           Materialize.toast('Evento enviado correctamente!', 3000, 'rounded')
        //       },
        //       error: function (error){
        //               console.log(error.responseText);
        //       }
      })
  $('ul.tabs').tabs();
})