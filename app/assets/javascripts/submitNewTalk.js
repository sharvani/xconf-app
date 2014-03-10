var submitNewTalk = function () {
    $("#submit_new_talk").on('click', function (e) {
        $("#newTalk").remove();
        $.ajax({
            url: '/topics/new',
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
                $("#submit_new_talk").css('color', 'rgb(180, 27, 88)');
                $(data).modal('show');
            },
            complete: function () {
                setTimeout(function () {
//                    $(".save-form").click(postMyForm)
//                    $("#reset").click(reset)
//                    $('#tags').tagsinput()
//                    $('#book_title').focus();
//                    $('#book_title').on('input', searchTitleRelatedBooks);
//                    enableAutocomplete();
                }, 500);
            }
        })
    });
}


$(document).ready(submitNewTalk)
$(document).on('page:load', submitNewTalk)
