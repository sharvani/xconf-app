var bindToVote = function () {
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
};

var addVoteForTopic = function (id, target) {

    $.ajax({
        url: '/topics/vote_for/' + id,
        type: 'GET',
        crossDomain: true,
        dataType: 'html',
        success: function () {
            target.addClass('vote-cast').removeClass('vote-open');
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
        }
    })
}

$(document).ready(bindToVote)
$(document).on('page:load', bindToVote)