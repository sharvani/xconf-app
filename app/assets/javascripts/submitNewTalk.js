var submitNewTalk = function () {
    $("#submit_new_talk").on('click', function (e) {

        $(".sidebar a").removeClass('active');
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
                            tagInput = $(".tagsinput input")
                            tagInput.attr('maxlength', 30);
                            if (tagCount >= 5) {
                                tagInput.hide();
                            } else {
                                tagInput.show().focus();
                            }
                        }

                    });
                    $("#submit_talk").click(createTalk);
                    $(".close").click(hideAlerts);
                    $("#topic_title").focus();
                    $("#talk").on('hidden.bs.modal', function () {
                        window.location.replace("/topics");
                    })
                }, 500);
            }
        })
    });
}

var createTalk = function (e) {
    e.preventDefault();
    hideAlerts();
    hideErrors();
    var valuesToSubmit = $("#new_topic").serialize();

    $.ajax({
        url: '/topics',
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
    $("input.form-control").focus($(this).css('box-shadow', '0 0 8px rgba(102, 175, 233, 0.6)'));
    $("textarea.form-control").css('border-color', '#cccccc').css('box-shadow', 'none');
    $("textarea.form-control").focus($(this).css('box-shadow', '0 0 8px rgba(102, 175, 233, 0.6)'));
}

$(document).ready(submitNewTalk)
$(document).on('page:load', submitNewTalk)
