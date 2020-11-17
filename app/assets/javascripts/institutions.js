$(function () {

    $('#institution_region').change(function () {
        var region = $(this).val()
        $.ajax({
            url: '/institutions/load_zones',
            data: {region: region},
            success: function (response) {
                $('#zone_display').html(response)
            }
        })
    })

    $('#institution_zone').change(function () {
        var zone = $(this).val()
        $.ajax({
            url: '/institutions/load_woredas',
            data: {zone: zone},
            success: function (response) {
                $('#woreda_display').html(response)
            }
        })
    })
});