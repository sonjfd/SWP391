    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
     */

    package AminController;

    import DAO.MedicineDAO;
    import Model.Medicine;
    import java.io.IOException;
    import java.io.PrintWriter;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import java.util.List;

    /**
     *
     * @author FPT
     */
    @WebServlet(name="UpdateMedicine", urlPatterns={"/admin-update-medicine"})
    public class UpdateMedicine extends HttpServlet {

        /** 
         * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet UpdateMedicine</title>");  
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Servlet UpdateMedicine at " + request.getContextPath () + "</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        } 

        // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
        /** 
         * Handles the HTTP <code>GET</code> method.
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            MedicineDAO medicineDAO = new MedicineDAO();
            try {
                String id = request.getParameter("id");
                Medicine medicine = medicineDAO.getMedicineById(id);
                if (medicine != null) {
                    request.setAttribute("medicine", medicine);
                    request.getRequestDispatcher("view/admin/content/UpdateMedicine.jsp").forward(request, response);
                } else {
                    List<Medicine> medicineList = medicineDAO.getAllMedicines();
                    request.setAttribute("medicineList", medicineList);
                    request.setAttribute("message", "Medicine not found.");
                    request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                List<Medicine> medicineList = medicineDAO.getAllMedicines();
                request.setAttribute("medicineList", medicineList);
                request.setAttribute("message", "Failed to load update medicine form.");
                request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);
            }
        } 

        /** 
         * Handles the HTTP <code>POST</code> method.
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            MedicineDAO medicineDAO = new MedicineDAO();
             try {
            request.setCharacterEncoding("UTF-8");

            String id = request.getParameter("id").trim();
            String name = request.getParameter("name").trim();
            String description = request.getParameter("description");
            int status = (request.getParameter("status") != null && request.getParameter("status").equals("1")) ? 1 : 0;

            Medicine medicine = new Medicine();
            medicine.setId(id);
            medicine.setName(name);
            medicine.setDescripton(description);
            medicine.setStatus(status);

            
            if (medicineDAO.isMedicineNameExists(name, id)) {
                request.setAttribute("error", "Tên thuốc đã tồn tại!");
                request.setAttribute("medicine", medicine); // giữ lại dữ liệu người dùng đã nhập
                request.getRequestDispatcher("view/admin/content/UpdateMedicine.jsp").forward(request, response);
                return;
            }

            
            boolean success = medicineDAO.updateMedicine(medicine);
            List<Medicine> medicineList = medicineDAO.getAllMedicines();
            request.setAttribute("medicineList", medicineList);
            request.setAttribute("message", success ? "Thuốc đã được cập nhật thành công!" : "Không thể cập nhật thuốc!");
            request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            List<Medicine> medicineList = medicineDAO.getAllMedicines();
            request.setAttribute("medicineList", medicineList);
            request.setAttribute("message", "Cập nhật thất bại do lỗi hệ thống.");
            request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);
        }
        }

        /** 
         * Returns a short description of the servlet.
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo() {
            return "Short description";
        }// </editor-fold>

    }
