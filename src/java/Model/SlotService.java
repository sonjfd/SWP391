package Model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class SlotService {

    public static List<Slot> generateSlots(Shift shift, List<Appointment> appointments, int slotMinutes) {
        List<Slot> result = new ArrayList<>();
        LocalDate today = LocalDate.now();
        LocalDateTime shiftStart = LocalDateTime.of(today, shift.getStart_time());
        LocalDateTime shiftEnd = LocalDateTime.of(today, shift.getEnd_time());

        if (shiftEnd.isBefore(shiftStart)) {
            shiftEnd = shiftEnd.plusDays(1);
        }
        LocalDateTime current = shiftStart;

        while (!current.plusMinutes(slotMinutes).isAfter(shiftEnd)) {
            LocalDateTime slotStart = current;
            LocalDateTime slotEnd = current.plusMinutes(slotMinutes);
            current = slotEnd;

            boolean isBooked = false;
            for (Appointment appt : appointments) {
                LocalDateTime apptStart = LocalDateTime.of(today, appt.getStartTime());
                LocalDateTime apptEnd = LocalDateTime.of(today, appt.getEndTime());

                if (apptEnd.isBefore(apptStart)) {
                    apptEnd = apptEnd.plusDays(1);
                }

                if (("booked".equalsIgnoreCase(appt.getStatus()) 
                        || "completed".equalsIgnoreCase(appt.getStatus()))
                        && slotStart.isBefore(apptEnd) && slotEnd.isAfter(apptStart)) {
                    isBooked = true;
                    break;
                }

            }

            result.add(new Slot(slotStart.toLocalTime(), slotEnd.toLocalTime(), !isBooked));
        }

        return result;
    }

}


