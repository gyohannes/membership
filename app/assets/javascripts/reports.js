$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#report_organization_unit_tree').treeview({
                data: response,
                levels: 0,
                onNodeSelected: function (event, data) {
                    $('#search_organization_unit').val(data.id)
                }
            });
        }
    });

});