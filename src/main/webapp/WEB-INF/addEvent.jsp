document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        events: 'getEventsServlet', // Fetch events from the servlet
        selectable: true,
        select: function(info) {
            var title = prompt('Event Title:');
            var description = prompt('Event Description:');
            if (title) {
                // Add the event to the calendar
                calendar.addEvent({
                    title: title,
                    start: info.startStr,
                    end: info.endStr,
                    description: description
                });
                
                // Send the new event to the server
                $.ajax({
                    url: 'AddEventServlet',
                    type: 'POST',
                    data: {
                        title: title,
                        start: info.startStr,
                        end: info.endStr,
                        description: description
                    },
                    success: function() {
                        calendar.refetchEvents(); // Refresh the events after adding
                    }
                });
            }
            calendar.unselect();
        }
    });
    calendar.render();
});
