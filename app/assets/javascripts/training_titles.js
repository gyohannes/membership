$(function () {
    $("#search_program_area, #search_training_title").on("input", function () {
        var program_area = $("#search_program_area").val();
        var training_title = $("#search_training_title").val();
        $.ajax({
            url: '/training_titles/load_training_titles',
            data: {program_area: program_area, training_title: training_title},
            cache: true,
            async: false,
            success: function (response) {
                $('#filtered_training_titles').html(response);
            }
        });
    });
})