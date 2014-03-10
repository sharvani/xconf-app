// var getSpeakers = function () {
//     $("#add_more_speakers").remove();
//     $(".edit-speakers").on('click', function (e) {
//         $.ajax({
//             url: '/topics/get_speakers/' + $($(e.target).parent()).attr("data-id"),
//             type: 'GET',
//             crossDomain: true,
//             dataType: 'html',
//             success: function (data) {
//                 $(data).modal('show');
//             },
//             complete: function () {
//                 setTimeout(function () {
//                     $("#add_speakers").click(addMoreSpeakers);
//                     $("#new_speakers").focus();
//                     $("#add_speakers").attr('disabled', true);
//                     $("#new_speakers").keyup(disableSubmit);
//                 }, 500);
//             }
//         })
//     });
// }

// var addMoreSpeakers = function () {
//     hideAlerts();
//     $(".alert-info").show();
//     $.ajax({
//         url: '/topics/add_speakers/' + $("#topic_id").val(),
//         type: 'GET',
//         data: { speakers: $("#new_speakers").val() },
//         crossDomain: true,
//         dataType: 'html',
//         success: function () {
//             window.location.replace("/users/registered_topics");
//         },
//         error: function (error) {
//             hideAlerts();
//             $(".alert-danger").text(error.responseText)
//             $(".alert-danger").show().delay(2000).slideUp(600);
//         }
//     })
// }

// var disableSubmit = function () {
//     if ($(this).val() != '') {
//         $("#add_speakers").attr('disabled', false);
//     }
//     else {
//         $("#add_speakers").attr('disabled', true);
//     }

// }

$(document).ready()
// $(document).on('page:load', function() {})
