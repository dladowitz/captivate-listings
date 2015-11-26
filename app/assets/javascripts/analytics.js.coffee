# http://stackoverflow.com/questions/18632644/google-analytics-with-rails-4
# Using this so we can use both Rails turbolinks and GA Events
# It would be nice to not send development page views to google.
# Look here for inspiration: http://reed.github.io/turbolinks-compatibility/google_analytics.html

# Probably need to precompile for production if changed

$(document).on 'page:change', ->
 if window._gaq?
  _gaq.push ['_trackPageview']
 else if window.pageTracker?
  pageTracker._trackPageview()

// Javascript
$(document).on('page:change', function() {
 if (window._gaq != null) {
  return _gaq.push(['_trackPageview']);
 } else if (window.pageTracker != null) {
  return pageTracker._trackPageview();
 }
});
