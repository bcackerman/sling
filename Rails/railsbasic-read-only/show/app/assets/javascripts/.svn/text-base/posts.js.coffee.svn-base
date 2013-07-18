# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $('#vid-s3-uploader').S3Uploader
    path: 'videos/'
  $('#vid-s3-uploader').bind 's3_uploads_start', (e) ->
    $('.upload-input-wrap').css('height', 0)
    $('.upload-box-button-container').hide()
    $('#upload-drag-drop-info').hide()
    $('.upload-header-status-text').html("Uploading...")
    $('.upload-input-form').fadeIn()
  $('#vid-s3-uploader').bind "s3_uploads_complete", (e, content) ->
    $('.create-video-button input').removeClass("disabled")
    $('.upload-header-status-text').html("Uploading finished.")
  $('#vid-s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")
  $('#vid-s3-uploader').bind "ajax:success", (e, data) ->
    alert("server was notified of new file on S3; responded with '#{data}")

  $('#vid-jf-uploader').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(mp4|ogv|mov|webm|wmv)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        $('.upload-input-wrap').css('height', 0)
        $('.upload-box-button-container').hide()
        $('#upload-drag-drop-info').hide()
        $('.upload-header-status-text').html("Uploading in progress...")
        data.context = $(tmpl("template-upload", file))
        $('#vid-jf-uploader').append(data.context)
        data.submit()
        $('.upload-input-form').fadeIn()
      else
        alert("#{file.name} is not a mp4, ogv, mov, or webm video file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.progress .bar').css('width', progress + '%')
        if data.loaded == data.total
          setTimeout ( ->
            $('.upload-progress').fadeOut()
            $('.upload-header-status-text').html("Saving in progress...")
            $('.progress-save').fadeIn()
          ), 500
    done: (e, data) ->
      $('.create-video-button input').removeClass("disabled")
      $('.upload-header-status-text').html("Upload completed.")
      $('.progress-save-img').hide()
      $('.progress-save strong').html("Please fill out the video info.")

  $('#post_skill_id').parent().hide()
  skills = $('#post_skill_id').html()
  $('#post_category_id').change ->
    category = $('#post_category_id :selected').text()
    escaped_category = category.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(skills).filter("optgroup[label='#{escaped_category}']").html()
    if options
      $('#post_skill_id').html(options)
      $('#post_skill_id').parent().show()
    else
      $('#post_skill_id').empty()
      $('#post_skill_id').parent().hide()

