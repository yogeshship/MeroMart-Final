package com.meromart.service;

import com.meromart.dao.CategoryDAO;
import com.meromart.dao.ProductDAO;
import com.meromart.model.CategoryModel;
import com.meromart.model.ProductModel;

import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    public boolean addProduct(ProductModel product) { return productDAO.addProduct(product); }
    public List<ProductModel> getAllProducts() { return productDAO.getAllProducts(); }
    public ProductModel getProductById(int id) { return productDAO.getProductById(id); }
    public boolean updateProduct(ProductModel product) { return productDAO.updateProduct(product); }
    public boolean deleteProduct(int id) { return productDAO.deleteProduct(id); }
    
    public List<CategoryModel> getAllCategories() { return categoryDAO.getAllCategories(); }
}