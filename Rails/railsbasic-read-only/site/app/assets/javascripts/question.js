function closeQuestion() {
  $(".apple_overlay_question .close").click();
}

function closeQuestionModal(status) {
  $('.new-question-inputs').hide();
  if (status == 'success') {
    $('.new-question-status').html("You have successfully asked a question, thank you.").fadeIn('slow');
    setTimeout(closeQuestion, 2000);
  } else {
    $('.new-question-status').html("Unknown error occurred: Please try again later!").fadeIn('slow');
  }
}

$(function(){

  $('.question-button a[data-remote]').live('ajax:beforeSend', function(e, xhr, settings){
    xhr.setRequestHeader('accept', '*/*;q=0.5, text/html, ' + settings.accepts.html);       
  });

  $('.question-button a[data-remote]').live('ajax:success', function(xhr, data, status){
    $('#modal-question-container').html(data).show();
 });

});

