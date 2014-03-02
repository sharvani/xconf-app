var setWrapperHeight = function () {

    if ($("body").height() < $(window).height()) {
        $('#wrapper').css({'height': (($(window).height()) - 40) + 'px'});
    }

}

$(document).ready(setWrapperHeight)
$(document).on('page:load', setWrapperHeight)
