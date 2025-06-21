/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class UploadedFile {
    private String id;
    private NurseSpecializationResult nurseResult;
    private String file_url;
    private String file_name;
    private Date uploaded_at;
    private String uploaderName;

    public UploadedFile() {
    }

    public UploadedFile(String id, NurseSpecializationResult nurseResult, String file_url, String file_name, Date uploaded_at) {
        this.id = id;
        this.nurseResult = nurseResult;
        this.file_url = file_url;
        this.file_name = file_name;
        this.uploaded_at = uploaded_at;
    }

    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public NurseSpecializationResult getNurseResult() {
        return nurseResult;
    }

    public void setNurseResult(NurseSpecializationResult nurseResult) {
        this.nurseResult = nurseResult;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public Date getUploaded_at() {
        return uploaded_at;
    }

    public void setUploaded_at(Date uploaded_at) {
        this.uploaded_at = uploaded_at;
    }

    public String getFile_name() {
        return file_name;
    }

    public void setFile_name(String file_name) {
        this.file_name = file_name;
    }

    public String getUploaderName() {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName) {
        this.uploaderName = uploaderName;
    }
    
    
    
    
}
