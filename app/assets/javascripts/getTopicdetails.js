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
                }, 500);
            }
        })
    });
}

var addVoteToTopic = function () {
    $("#getTopicModal").remove();
    $.ajax({
        url: '/topics/vote_for/' + $("#topic_id").val(),
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function (votes) {
            $(".alert-success").show();
            $("#no_of_votes").text(votes)
        }
    })
}


$(document).ready(getTopicDetails)
$(document).on('page:load', getTopicDetails)
