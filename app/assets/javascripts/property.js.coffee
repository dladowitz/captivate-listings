jQuery ->
  # For sorting photos
  $('#photos').sortable(
    # axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  # S3 Uploader - Used when only a single uploader is on the page
  # $("#s3-uploader").S3Uploader()

  $("#s3-uploader").S3Uploader
    before_add: (file) ->
      if(file.size > 21857600) ##100 megabytes
        alert("Upload Error: File Over 20MB")
        false
      else
        if(file.type == "image/jpeg")
          true
        else if(file.type == "image/png")
          true
        else
          alert("Upload Error: " + file.type + " unsupported.\nPlease upload a JPG or PNG.")
          false

  $("#disclosures-s3-uploader").S3Uploader
    before_add: (file) ->
      if(file.size > 21857600) ##100 megabytes
        alert("Upload Error: File Over 20MB")
        false
      else
        console.log("File type is: ")
        console.log(file.type)
        true
        # If we get worried about what is being uploaded we can start filtering
        # if(file.type == "image/jpeg")
        #   true
        # else if((file.type == "image/png"))
        #   true
        # else if(file.type == "application/pdf")
        #   true
        # else if(file.type == "application/zip")
        #   true
        # else if(file.type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
        #   true
        # else if(file.type == "application/msword")
        #   true
        # else
        #   alert("Upload Error: " + file.type + " unsupported.\nPlease upload a JPG or PNG.")
        #   false

  $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
    # alert("#{content.filename} Successfully Uploaded")
    $('#someHiddenField').val(content.url)

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


checkWidth = (file) ->
  alert 'Checking: ' + file.size
  true
