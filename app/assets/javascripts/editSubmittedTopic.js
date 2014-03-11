var editTalk = function () {
    $(".edit-talk").click(function () {
        var id = $(this).attr("data-edit-id")
        $("#talk").remove();
        $.ajax({
            url: '/topics/' + id + '/edit',
            type: 'GET',
            crossDomain: true,
            dataType: 'html',
            success: function (data) {
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
                    $("#submit_talk").click(updateTalk(id));
                    $(".close").click(hideAlerts);
                    $("#topic_title").focus();
                }, 500);
            }
        })
    });
}

var updateTalk = function (id) {
    return function(e) {
        e.preventDefault();
        hideAlerts();
        hideErrors();
        var valuesToSubmit = $("#edit_topic_" + id).serialize();

        $.ajax({
            url: '/topics/' + id,
            type: 'PUT',
            data: valuesToSubmit,
            dataType: 'json',
            success: function () {
                window.location.replace("/topics");
            },
            error: function (errors) {
                $(".alert-danger").show();
                highlightErrors(errors)
            }
        })
    }

}

$(document).ready(editTalk)
$(document).on('page:load', editTalk)
