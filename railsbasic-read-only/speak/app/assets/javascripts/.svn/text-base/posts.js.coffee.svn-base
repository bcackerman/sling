# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@VideoProcessPoller =
  poll: ->
    if $('#video-blog-process').length > 0
      if $('#video-process-pending').length > 0
        setTimeout @request, 10000

  request: ->
    $.get("/posts/channel.js", "&vid_process=true", null, "script")

jQuery ->

  if $('#video-blog-process').length > 0
    VideoProcessPoller.poll()

  $('#vid-jf-uploader').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(mp4)$/i
      file = data.files[0]
      if file.size >= 50000000
        alert("Video file size is too big, maximum allowed is 50MB.")
        return
      if types.test(file.type) || types.test(file.name)
        $('.upload-input-wrap').css('height', 0)
        $('.upload-box-button-container').hide()
        $('#upload-drag-drop-info').hide()
        $('#upload-box-right-column').hide()
        $('.form-main-header-status').html("Uploading in progress...")
        data.context = $($.parseHTML(tmpl("template-upload", file))[1])
        $('#vid-jf-uploader').append(data.context)
        data.submit()
        $('.upload-input-form').fadeIn()
        $('#new_post').resetClientSideValidations()
      else
        alert("Sorry, the only video format supported for now is: mp4")
        return
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.progress .bar').css('width', progress + '%')
        if data.loaded == data.total
          setTimeout ( ->
            $('.upload-progress').fadeOut()
            $('.form-main-header-status').html("Saving in progress...")
            $('.progress-save').fadeIn()
          ), 500
    done: (e, data) ->
      $('.create-button input').attr("disabled", false);
      $('.form-main-header-status').html("Processing video... This may take a while.")
      $('.progress-save-img').hide()
      $('.progress-save strong').html("Please fill out the video info and create post first.")

