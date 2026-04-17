package com.shaheed.config;

import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class AppInitializer extends
        AbstractAnnotationConfigDispatcherServletInitializer {

    private static final long MAX_FILE_SIZE    = 5  * 1024 * 1024;  // 5 MB per file
    private static final long MAX_REQUEST_SIZE = 25 * 1024 * 1024;  // 25 MB total (5 files)
    private static final int  FILE_THRESHOLD   = 0;

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{ HibernateConfig.class };
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{ WebMvcConfig.class, WebConfig.class };
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{ "/" };
    }

    @Override
    protected void customizeRegistration(
            ServletRegistration.Dynamic registration) {

        MultipartConfigElement multipartConfig = new MultipartConfigElement(
                System.getProperty("java.io.tmpdir"),
                MAX_FILE_SIZE,
                MAX_REQUEST_SIZE,
                FILE_THRESHOLD
        );

        registration.setMultipartConfig(multipartConfig);
    }
}