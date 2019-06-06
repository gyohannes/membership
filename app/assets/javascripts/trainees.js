$(function () {
    var training = $('#training').val();
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#trainee_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    $.ajax({
                        url:'/trainees/load_trainees',
                        data: { node: data.id, training: training},
                        success: function (response) {
                            $('#trainees').html(response)
                            $('.dataTable').DataTable();
                        }
                    })
                }
            });
        }
    });

});