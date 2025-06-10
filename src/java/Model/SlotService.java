package Model;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class SlotService {

    public static List<Slot> generateSlots(Shift shift, List<Appointment> appointments, int slotMinutes) {
        List<Slot> result = new ArrayList<>();

        LocalTime current = shift.getStart_time();
        LocalTime end = shift.getEnd_time();

        while (current.plusMinutes(slotMinutes).compareTo(end) <= 0) {
            LocalTime slotStart = current;
            LocalTime slotEnd = current.plusMinutes(slotMinutes);
            current = slotEnd;

            boolean isBooked = false;
            for (Appointment appt : appointments) {
                LocalTime apptStart = appt.getStartTime();
                LocalTime apptEnd = appt.getEndTime();

                if ("completed".equalsIgnoreCase(appt.getStatus())
                        && !(slotEnd.compareTo(appt.getStartTime()) <= 0 || slotStart.compareTo(appt.getEndTime()) >= 0)) {
                    isBooked = true;
                    break;
                }

            }

            result.add(new Slot(slotStart, slotEnd, !isBooked));
        }

        return result;
    }
}
