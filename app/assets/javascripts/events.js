$(document).ready(function(){
      $('.js-menu li a.waves-effect').on('click', function(e){
            console.log('kjsdjj')
            e.preventDefault();
      })
      $('.js-add-task').on('click', function(){
      	var task_type = $(this).data('type');
      	$.ajax({
      		url: window.location.pathname + '/tasks/new',
      		data: {type: task_type},
                datatype: 'html', 
      		success: createChoice,
      		error: function (error){
      			console.log(error.responseText);
      		}
      	})
      })
      function createChoice (data){
      	$('.choiceForm').html(data);
      }
  
      // Initialize collapse button
  $(".button-collapse").sideNav();
  // Initialize collapsible (uncomment the line below if you use the dropdown variation)
  //$('.collapsible').collapsible();
  $('.button-collapse').sideNav('show');
   $('.modal').modal();
    })