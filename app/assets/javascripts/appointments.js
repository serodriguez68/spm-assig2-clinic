(function($, window) {
    $.fn.replaceOptions = function(options) {
        var self, $option;

        this.empty();
        self = this;

        $.each(options, function(index, option) {
            $option = $("<option></option>")
                .attr("value", option.value)
                .text(option.text);
            self.append($option);
        });
    };
})(jQuery, window);



$( document ).ready(function() {


    // APPOINTMENT SPECIALTY CHANGE
    $("#appointment_specialty_select").change(handleSpecialtyChange);
    
    // Change handlers
    function handleSpecialtyChange(event) {
        let specialty_id = $("#appointment_specialty_select").val();
        if (!!specialty_id) {
            replaceHCPOptions(specialty_id);
            // Enable HCP select
            $("#appointment_hcp_select").prop('disabled', false);

        } else {
            $("#appointment_hcp_select").val('');
            $("#appointment_hcp_select").prop('disabled', true);
            $("#appointment_hcp_select").change();
        }
    }

    function replaceHCPOptions(specialty_id) {
        $.get( "/health_care_professionals/index_of_specialty?specialty_id=" + specialty_id, function( data ) {

            // Extract options for select from data
            let options = data.map(function (hcp) {
                return {
                    text: `${hcp.name} ($${hcp.consultation_fee})`,
                    value: hcp.id
                }
            });
            console.log("Updating HCP options");
            $("#appointment_hcp_select").replaceOptions(options);
            // Select the first option
            $("#appointment_hcp_select").prop("selectedIndex", 0);
            // Trigger change
            $("#appointment_hcp_select").change();
        }, "json" );
    }


    // HCP CHANGE
    $("#appointment_hcp_select").change(handleHCPChange);

    // Change handlers
    function handleHCPChange() {
        let hcp_id = $("#appointment_hcp_select").val();
        console.log(`Handling HCP Change. HCP id: ${hcp_id}`);

        if (!!hcp_id) {
            // There is an hcp_id

            // Enable search by date
            $("#appointment_from_date").prop('disabled', false);
            $("#appointment_to_date").prop('disabled', false);

        } else {
            // Disable dates
            $("#appointment_from_date").prop('disabled', true);
            $("#appointment_to_date").prop('disabled', true);

            // Set available appointment to blank
            $("#appointment_start_time").val('');
        }

        // Trigger search date change
        $("#appointment_from_date").change();

    }

    // HANDLE DATE CHANGE
    $("#appointment_from_date").change(handleDateChange);
    $("#appointment_to_date").change(handleDateChange);

    // Change handlers
    function handleDateChange() {
        let from_date = $("#appointment_from_date").val();
        let to_date = $("#appointment_to_date").val();
        let hcp_id = $("#appointment_hcp_select").val();
        console.log(`Handling Date Change. HCP: ${hcp_id}, From date: ${from_date}, To date: ${to_date}`);

        if(!!from_date && !!to_date && !!hcp_id) {
            // Both dates are present
            // Replace Available Appointment Options
            replaceAppointmentOptions(hcp_id, from_date, to_date);

            // Enable appointment selector
            $("#appointment_start_time").prop('disabled', false);


        } else {

            // Select Blank for appointment selector and disable
            $("#appointment_start_time").val('');
            $("#appointment_start_time").prop('disabled', true);

        }
    }

    function replaceAppointmentOptions(hcp_id, from_date, to_date) {
        $.get( `/appointments/available_slots_between?health_care_professional_id=${hcp_id}&from_date=${from_date}&to_date=${to_date}`, function( data ) {

            // Extract options for select from data
            let options = data.map(function (datetime) {
                let date = new Date(datetime);
                return {
                    text: `${date.toDateString()} at ${date.getHours()}:00`,
                    value: datetime
                }
            });


            if (options.length !== 0) {
                // There are options available
                console.log("Updating Appointment Options");
                $("#appointment_start_time").replaceOptions(options);
                // Select the first option
                $("#appointment_start_time").prop("selectedIndex", 0);
            } else {
                // There are no options available
                default_option = [{text: "There are no appointments available. Please try a different date range.", value: null}]
                $("#appointment_start_time").replaceOptions(default_option);
                $("#appointment_start_time").prop('disabled', true);
            }


        }, "json" );
    }


});



