package Model;

import Model.Appointment;
import Model.DoctorSchedule;
import java.util.*;

public class SlotService {
    // slotMinutes: 30 = slot 30p, 15 = slot 15p...

    public List<Slot> generateSlots(Shift shift, Date workDate, List<Appointment> appointments, int slotMinutes) {
        List<Slot> result = new ArrayList<>();

        Calendar slotCal = Calendar.getInstance();
        slotCal.setTime(workDate);

// Sử dụng LocalTime để lấy giờ/phút
        slotCal.set(Calendar.HOUR_OF_DAY, shift.getStart_time().getHour());
        slotCal.set(Calendar.MINUTE, shift.getStart_time().getMinute());
        slotCal.set(Calendar.SECOND, 0);
        slotCal.set(Calendar.MILLISECOND, 0);

        Calendar endCal = Calendar.getInstance();
        endCal.setTime(workDate);
        endCal.set(Calendar.HOUR_OF_DAY, shift.getEnd_time().getHour());
        endCal.set(Calendar.MINUTE, shift.getEnd_time().getMinute());
        endCal.set(Calendar.SECOND, 0);
        endCal.set(Calendar.MILLISECOND, 0);

        while (slotCal.getTime().before(endCal.getTime())) {
            Date slotStart = slotCal.getTime();
            slotCal.add(Calendar.MINUTE, slotMinutes);
            Date slotEnd = slotCal.getTime();
            if (slotEnd.after(endCal.getTime())) {
                break;
            }

            // Check slot này đã được đặt chưa
            boolean isBooked = false;
            for (Appointment appt : appointments) {
                if (!(slotEnd.compareTo(appt.getStartTime()) <= 0 || slotStart.compareTo(appt.getEndTime()) >= 0)) {
                    isBooked = true;
                    break;
                }
            }
            result.add(new Slot(slotStart, slotEnd, !isBooked));
        }
        return result;
    }
}
