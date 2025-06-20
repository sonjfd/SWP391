package Model;

import java.util.Date;

public class MedicalRecordFile {
    private String id;
    private String medicalRecordId;
    private String fileName;     // Tên file gốc
    private String fileUrl;      // Đường dẫn thực tế
    private Date uploadedAt;

    // Constructors
    public MedicalRecordFile() {}

    public MedicalRecordFile(String id, String medicalRecordId, String fileName, String fileUrl, Date uploadedAt) {
        this.id = id;
        this.medicalRecordId = medicalRecordId;
        this.fileName = fileName;
        this.fileUrl = fileUrl;
        this.uploadedAt = uploadedAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(String medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public Date getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(Date uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    @Override
    public String toString() {
        return "MedicalRecordFile{" + "id=" + id + ", medicalRecordId=" + medicalRecordId + ", fileName=" + fileName + ", fileUrl=" + fileUrl + ", uploadedAt=" + uploadedAt + '}';
    }

    
}
