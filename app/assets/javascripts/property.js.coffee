jQuery ->
  # For sorting photos
  $('#photos').sortable(
    # axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  # S3 Uploader - Used when only a single uploader is on the page
  $("#s3-uploader").S3Uploader()

  # $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    # alert("#{content.filename} Successfully Uploaded")
    # $('#someHiddenField').val(content.url)

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")

  # Used when multiple uploaders are on page. Differentiated by id
  $("#s3-uploader-main-background").S3Uploader()

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")


  $("#s3-uploader-neighborhood-background").S3Uploader()

  $('#s3-uploader-neighborhood-background').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")


  $("#s3-uploader-contact-background").S3Uploader()

  $('#s3-uploader-contact-background').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")
