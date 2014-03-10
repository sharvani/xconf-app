var submitNewTalk = function () {
    $("#submit_new_talk").on('click', function (e) {
        $("#new_talk").remove();
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
                    $('#tag1').tagsInput({
                        'width': '100%',
                        'defaultText': 'Add a speaker',
                        'onChange': function () {
                            var tagCount = $(".tagsinput .tag").length;
                            if (tagCount >= 5) {
                                $(".tagsinput input").hide();
                            } else {
                                $(".tagsinput input").show().focus();
                            }
                        }

                    });
                    $("#submit_talk").click(postMyForm)
                    $("#topic_title").focus();
                }, 500);
            }
        })
    });
}

var postMyForm = function (e) {
    e.preventDefault();
    hideAlerts();
    hideErrors();
    var valuesToSubmit = $("#new_topic").serialize();

    $.ajax({
        url: '/topics/create',
        type: 'POST',
        data: valuesToSubmit,
        dataType: 'json',
        success: function (data) {
            window.location.replace("/topics");
        },
        error: function (errors) {
            $(".alert-danger").show();
            highlightErrors(errors)
        }
    })
}

var highlightErrors = function (errors) {
    var errorJson = JSON.parse(errors.responseText);
    for (var key in errorJson) {
        $("#topic_" + key).css('border-color', 'rgb(239, 91, 161)').css('box-shadow', '0 0 8px rgba(239, 91, 161, 0.6)');
    }
}

var hideErrors = function () {
    $("input.form-control").css('border-color', '#cccccc').css('box-shadow', 'none');
    $("textarea.form-control").css('border-color', '#cccccc').css('box-shadow', 'none');
}

$(document).ready(submitNewTalk)
$(document).on('page:load', submitNewTalk)
