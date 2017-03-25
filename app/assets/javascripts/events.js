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


  // $('input[name="option"]').on('change', function(e){
  //     console.log(e.currentTarget);
  //     var price = parseFloat($("#"+e.currentTarget.id+"-price").text().split("€")[0])
  //     if (price){
  //     var total = parseFloat($('#total-price').text()) + price;
  //     var newTotal = price + total;
  //     $('#total-price').text(newTotal);
  //   }
  //})
})