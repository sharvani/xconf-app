var getTopicDetails = function () {

    $(".topic-title").on('click', function (e) {
        $("#getTopicModal").remove();
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
                    $("#contribute").click(addContributorToTopic)
                }, 500);
            }
        })
    });
}

var addVoteToTopic = function () {
    $.ajax({
        url: '/topics/vote_for/' + $("#topic_id").val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function (votes) {
            hideAlerts();
            $(".alert-success").show();
            $(".alert-success").text("You vote is successfully being registered")
            $("#no_of_votes").text(votes)
        },
        error: function(error) {
            hideAlerts();
            $(".alert-danger").text(error.responseText)
            $(".alert-danger").show()
        }
    })
}

var addContributorToTopic = function() {
    $.ajax({
        url: '/topics/contribute_for/' + $("#topic_id").val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function (contributor) {
            hideAlerts();
            $("#speakers_list").append("<span>" + contributor + "</span>")
            $(".alert-success").text("You are being registered as a speaker of the topic")
            $(".alert-success").show();
        },
        error: function(error) {
            hideAlerts();
            $(".alert-danger").text(error.responseText)
            $(".alert-danger").show()
        }
    })
}

var hideAlerts = function() {
    $(".alert").hide();
}

$(document).ready(getTopicDetails)
$(document).on('page:load', getTopicDetails)
