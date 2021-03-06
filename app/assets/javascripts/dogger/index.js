//= require dogger/jquery-3.3.1.min
//= require dogger/popper.min
//= require dogger/bootstrap.min
//= require dogger/owl.carousel.min
//= require dogger/jquery.countdown.min
//= require dogger/jquery.easing.1.3
//= require dogger/aos
//= require dogger/jquery.fancybox.min
//= require dogger/jquery.sticky
//= require dogger/isotope.pkgd.min
//= require dogger/main

$('#user_user_type').change(function () {
    var user_type = $(this).val();
    var role;
    if (user_type == 'Individual Membership'){
        role = 'Member'
    }else if (user_type == 'Student Membership'){
        role = 'Student'
    }else if (user_type == 'Institution Membership'){
        role = 'Institution'
    }
    $('#user_role').val(role)
})