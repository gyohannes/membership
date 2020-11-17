$(function () {

    $(function () {
        $.ajax({
            url: '/organization_units/load_tree',
            success: function(response){
                $('#member_organization_tree').treeview({
                    data: response,
                    levels: 2,
                    onNodeSelected: function (event, data) {
                        $('#individual_person_attributes_organization_unit_id').val(data.id)
                        $('#student_person_attributes_organization_unit_id').val(data.id)
                    }
                });
            }
        });

    });

    $("#person_profession_category_id").change(function(){
        var profession_category = $(this).val();
        $.ajax({
            url: '/people/load_professions',
            data: { profession_category: profession_category},
            cache: true,
            async: false,
            beforeSend: function(){
                $("#profession_loading_indicator").show();
            },
            error: function(){
                $("#profession_loading_indicator").hide();
            },
            success: function(response){
                $('#professions_display').html(response);
                $("#profession_loading_indicator").hide();
            }
        });
    });

    $('#profession_loading_indicator').hide();
});