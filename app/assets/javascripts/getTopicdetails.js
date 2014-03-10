var getTopicDetails = function () {

    $(".topic-title").on('click', function (e) {
        $("#get_topic_details").remove();
        $.ajax({
            url: '/topics/' + $(e.target).attr("data-id"),
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $(data).modal('show');
            },
            complete: function () {
                setTimeout(function () {
                    $("#vote").click(addVoteToTopic)
                    $("#revoke").click(revokeVoteFromTopic)
                }, 500);
            }
        })
    });
}




var hideAlerts = function () {
    $(".alert").hide();
}

$(document).ready(getTopicDetails)
$(document).on('page:load', getTopicDetails)
