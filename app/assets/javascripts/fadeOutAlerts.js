var fadeOutNoticeAlert = function() {
    $("#notice").delay(2000).slideUp(600);
}


$(document).ready(fadeOutNoticeAlert)
$(document).on('page:load', fadeOutNoticeAlert)
