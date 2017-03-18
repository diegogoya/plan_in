$(document).ready(function(){
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
    })