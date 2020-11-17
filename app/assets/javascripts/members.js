$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#members_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/members/load_members',
                        data: { node: data.id},
                        success: function (response) {
                            $('#people').html(response)
                            $('.js-exportable').DataTable({
                                dom: 'lrBfrtip',
                                responsive: true,
                                buttons: [
                                    'copy', 'excel'
                                ]
                            });
                        }
                    })
                }
            });
        }
    });

    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#members_paid_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/members/load_members_paid',
                        data: { node: data.id},
                        success: function (response) {
                            $('#members_paid').html(response)
                            $('.js-exportable').DataTable({
                                dom: 'lrBfrtip',
                                responsive: true,
                                buttons: [
                                    'copy', 'csv', 'excel', 'pdf', 'print'
                                ]
                            });
                        }
                    })
                }
            });
        }
    });

    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#members_not_paid_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/members/load_members_not_paid',
                        data: { node: data.id},
                        success: function (response) {
                            $('#members_not_paid').html(response)
                            $('.js-exportable').DataTable({
                                dom: 'lrBfrtip',
                                responsive: true,
                                buttons: [
                                    'copy', 'csv', 'excel', 'pdf', 'print'
                                ]
                            });
                        }
                    })
                }
            });
        }
    });

    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#id_cards_tree').treeview({
                data: response,
                levels: 0,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/members/load_paid_members',
                        data: { node: data.id},
                        success: function (response) {
                            $('#paid_members').html(response)
                            $('.js-exportable').DataTable({
                                retrieve: true,
                                responsive: true,
                                dom: '<"html5buttons"B>lTfgtip',
                                buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
                            });
                        }
                    })
                }
            });
        }
    });

})