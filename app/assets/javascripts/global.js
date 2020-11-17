(function ($) {
    'use strict';
    $(function ($) {
        //iCheck init
        $('input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_square-blue',
        });

        $('#check_all').iCheck({
            checkboxClass: 'icheckbox_square-blue',
        }).on('ifChanged', function(){
            var checked = $(this).prop("checked");
            var check_boxes = $('input[type="checkbox"]');
            if (checked==   true){
                check_boxes.iCheck("check");
            }else {
                check_boxes.iCheck("uncheck");
            }
        });

        $('input[type="radio"]').iCheck({
            radioClass: 'iradio_square-blue'
        });

        $('.date_picker').calendarsPicker({
            dateFormat: 'dd/mm/yyyy',
        });

        $('#individual_person_attributes_date_of_birth, #student_person_attributes_date_of_birth').calendarsPicker({
            dateFormat: 'dd/mm/yyyy',
            maxDate: '-18y'
        });



        $('.js-exportable').DataTable({
            retrieve: true,
            responsive: true,
            dom: '<"html5buttons"B>lTfgtip',
            buttons: ['copy', 'excel']
        });

        $('.wysihtml5').wysihtml5({'toolbar': {'blockquote': false, 'html': true}})

        $('#mainTable').editableTableWidget()
        $('.best_in_place').best_in_place();

        $( "select" ).select2({
            theme: "bootstrap"
        });



    });
}(jQuery))