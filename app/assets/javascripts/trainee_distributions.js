$(function () {
    $.ajax({
        url: '/organization_units/load_tree',
        success: function(response){
            $('#trainee_distribution_tree').treeview({
                data: response,
                levels: 2,
                onNodeSelected: function (event, data) {
                    var  training  = $("#training").val();
                    $.ajax({
                        url:'/trainings/load_distribution',
                        data: { node: data.id, training: training},
                        success: function (response) {
                            $('#trainee_distributions').html(response)
                        }
                    })
                }
            });
        }
    });

});