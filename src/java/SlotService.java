import Model.Appointment;
import Model.Shift;
import Model.Slot;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.sql.Time;

public class SlotService {

    // slotMinutes: 30 = 30 phút/slot, 15 = 15 phút/slot...
    public List<Slot> generateSlots(Shift shift, List<Appointment> appointments, int slotMinutes) {
        List<Slot> result = new ArrayList<>();

        LocalTime current = shift.getStart_time();
        LocalTime end = shift.getEnd_time();

        while (current.plusMinutes(slotMinutes).compareTo(end) <= 0) {
            LocalTime slotStart = current;
            LocalTime slotEnd = current.plusMinutes(slotMinutes);
            current = slotEnd;

            // Check xem có bị trùng với lịch đã đặt hay không
            boolean isBooked = false;
            for (Appointment appt : appointments) {
                LocalTime apptStart = appt.getStartTime();
                LocalTime apptEnd = appt.getEndTime();

                if (!(slotEnd.compareTo(apptStart) <= 0 || slotStart.compareTo(apptEnd) >= 0)) {
                    isBooked = true;
                    break;
                }
            }

            result.add(new Slot(slotStart, slotEnd, !isBooked));
        }

        return result;
    }
}
