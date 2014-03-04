var getSpeakers = function () {
    $("#add_more_speakers").remove();
    $(".edit-speakers").on('click', function (e) {
        $.ajax({
            url: '/topics/get_speakers/' + $($(e.target).parent()).attr("data-id"),
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $(data).modal('show');
            },
            complete: function () {
                setTimeout(function () {
                    $("#add_speakers").click(addMoreSpeakers)
                }, 500);
            }
        })
    });
}

var addMoreSpeakers = function () {
    $.ajax({
        url: '/topics/add_speakers/' + $("#topic_id").val(),
        type: 'GET',
        data: { speakers: $("#new_speakers").val() },
        crossDomain: true,
        dataType: 'html',
        success: function() {
            window.location.replace("/topics");
        }
    })
}


$(document).ready(getSpeakers)
$(document).on('page:load', getSpeakers)
