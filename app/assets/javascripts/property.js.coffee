jQuery ->
  # For sorting photos
  $('#photos').sortable(
    # axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  # S3 Uploader
  $("#s3-uploader").S3Uploader()

  # $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
  #   alert("#{content.filename} Successfully Uploaded")
  #   $('#someHiddenField').val(content.url)

  $('#s3-uploader').bind "s3_upload_failed", (e, content) ->
    alert("#{content.filename} failed to upload : #{content.error_thrown}")
