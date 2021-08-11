package com.cyco.utils;

public class FileVO {
//	글번호
    private Integer fileno;
//	부모 글번호
    private Long parentPK;
//	파일명
    private String filename;
//	실제 파일명
    private String realname;
//	파일 크기
    private long filesize;
    
    /**
     * 파일 크기를 정형화하기.
     */
    public String size2String() {
        Integer unit = 1024;
        if (filesize < unit) {
            return String.format("(%d B)", filesize);
        }
        int exp = (int) (Math.log(filesize) / Math.log(unit));

        return String.format("(%.0f %s)", filesize / Math.pow(unit, exp), "KMGTPE".charAt(exp - 1));
    }
    
    public Integer getFileno() {
        return fileno;
    }

    public void setFileno(Integer fileno) {
        this.fileno = fileno;
    }

    public Long getParentPK() {
        return parentPK;
    }
    
    public void setParentPK(Long parentPK) {
        this.parentPK = parentPK;
    } 
    
    public String getFilename() {
        return filename;
    }
    
    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    public String getRealname() {
        return realname;
    }
    
    public void setRealname(String realname) {
        this.realname = realname;
    }
    
    public long getFilesize() {
        return filesize;
    }
    
    public void setFilesize(long filesize) {
        this.filesize = filesize;
    }
    
}
