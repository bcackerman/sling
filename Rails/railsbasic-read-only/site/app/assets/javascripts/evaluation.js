function closeEvaluation() {
  $(".apple_overlay_evaluation .close").click();
}

function closeEvaluationModal(status) {
  $('.new-evaluation-inputs').hide();
  if (status == 'success') {
    $('.new-evaluation-status').html("Thank you for your valuable speech evaluation.").fadeIn('slow');
    setTimeout(closeEvaluation, 2000);
  } else {
    $('.new-evaluation-status').html("Unknown error occurred: Please try again later!").fadeIn('slow');
  }
}

$(function(){

  $('.evaluation-button a[data-remote]').live('ajax:beforeSend', function(e, xhr, settings){
    xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);       
  });

  $('.evaluation-button a[data-remote]').live('ajax:success', function(xhr, data, status){
    $('#modal-evaluation-container').html(data).show();
 });

});

