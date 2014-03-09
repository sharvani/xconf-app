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
                    $("#abstain").click(abstainVoteFromTopic)
                }, 500);
            }
        })
    });
}

var addVoteToTopic = function () {
    hideAlerts();
    $(".alert-info").show();
    $.ajax({
        url: '/topics/vote_for/' + $("#topic_id").val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function (votes) {
            hideAlerts();
            window.location.replace("/topics");
        },
        error: function (error) {
            hideAlerts();
            $(".alert-danger").text(error.responseText)
            $(".alert-danger").show().delay(2000).slideUp(600);
        }
    })
}

var abstainVoteFromTopic = function () {
    hideAlerts();
    $(".alert-info").show();
    $.ajax({
        url: '/topics/abstain_vote/' + $("#topic_id").val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function () {
            window.location.replace("/users/voted_topics");
        }
    })
}


var hideAlerts = function () {
    $(".alert").hide();
}

$(document).ready(getTopicDetails)
$(document).on('page:load', getTopicDetails)
