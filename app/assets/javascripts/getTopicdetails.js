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

                }, 500);
            }
        })
    });
}

$(document).ready(getTopicDetails)
$(document).on('page:load', getTopicDetails)
