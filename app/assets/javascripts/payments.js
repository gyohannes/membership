$(function () {
    $('#payment_budget_year_id, #payment_member_id').on('change', function () {
        var budget_year = $('#payment_budget_year_id').val()
        var member = $('#payment_member_id').val()
        $.ajax({
            url: '/payments/load_amount',
            data: {budget_year: budget_year, member: member},
            success: function (response) {
                $('#amount_display').html(response)
            }
        })
    })

    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#payments_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/payments/load_payments',
                        data: { node: data.id},
                        success: function (response) {
                            $('#payments').html(response)
                            $('.js-exportable').DataTable({
                                responsive: true,
                                dom: '<"html5buttons"B>lTfgtip',
                                buttons: ['copy', 'excel']
                            });
                        }
                    })
                }
            });
        }
    });
})