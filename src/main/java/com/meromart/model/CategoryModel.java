package com.meromart.model;

public class CategoryModel {
    private int id;
    private String name;
    private String label;
    private String description;
    private int productCount;
    private String status;
    private String statusClass;
    private String icon;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getProductCount() { return productCount; }
    public void setProductCount(int productCount) { this.productCount = productCount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getStatusClass() { return statusClass; }
    public void setStatusClass(String statusClass) { this.statusClass = statusClass; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
}
