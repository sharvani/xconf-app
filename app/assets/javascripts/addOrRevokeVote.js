var bindToVote = function () {

    checkForVotes();

    $(".vote").click(function (e) {
        e.preventDefault();
        var target = $(this);
        var id = target.attr('data-id');
        if (target.hasClass('vote-open')) {
            addVoteForTopic(id, target)
        }
        else {
            revokeVoteFromTopic(id, target)
        }
    })
}

var addVoteForTopic = function (id, target) {

    $.ajax({
        url: '/topics/vote_for/' + id,
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function () {
            target.addClass('vote-cast').removeClass('vote-open');
            checkForVotes();
        }
    })
}

var revokeVoteFromTopic = function (id, target) {

    $.ajax({
        url: '/topics/revoke_vote/' + id,
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function () {
            target.addClass('vote-open').removeClass('vote-cast');
            checkForVotes();
        }
    })
}

var checkForVotes = function () {
    if ($(".vote-cast").length == 3) {
        $.each($(".vote"), function (index, value) {
            if ($(value).hasClass('vote-open')) {
                $(this).addClass('vote-disabled').removeClass('vote-open');
            }
        });
    }

    else {
        $.each($(".vote"), function (index, value) {
            if ($(value).hasClass('vote-disabled')) {
                $(this).addClass('vote-open').removeClass('vote-disabled');
            }
        });
    }
}

$(document).ready(bindToVote)
$(document).on('page:load', bindToVote)