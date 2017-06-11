$(document).on('turbolinks:load', function(){
    /**
     * toggle the form considering it's visibility
     * @return slideUp if :visible === true | slideDown if :visible === false
     */
    $('.new-post-btn').on('click', function (e) {
        e.preventDefault();
        console.log('qwe');
        var form = $('.new-post-form');
        return (form.is(':visible') === true) ? form.slideUp('slow') : form.slideDown('slow');
    });
});
