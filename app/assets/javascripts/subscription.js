$(document).ready(function (){
    $('#subscribemailing').submit(function(){
        var email = $('#subscribemailingfield').val();

        if(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)) {
            $('#subscribemailing').addClass('d-none');
            $('#subscribedmessage').removeClass('d-none');
            r46('subscription', 'mailings', email, {'segment': 9264});
        }
        return false;
    });
});