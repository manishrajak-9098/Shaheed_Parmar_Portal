package com.shaheed.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.shaheed")
public class WebMvcConfig implements WebMvcConfigurer {
    @Value("${app.upload.dir:${upload.dir:}}")
    private String configuredUploadDir;

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(1);
        return resolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 1. CSS/JS ke liye
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(resolveUploadLocations())
                .setCachePeriod(0);
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    private String resolveUploadDir() {
        if (configuredUploadDir != null && !configuredUploadDir.isBlank()) {
            return configuredUploadDir;
        }
        Path projectUploads = Paths.get(System.getProperty("user.dir"), "src", "main", "webapp", "uploads");
        if (projectUploads.toFile().exists()) {
            return projectUploads.toString();
        }
        Path fallbackPath = Paths.get(System.getProperty("user.home"), "shaheed-uploads");
        return fallbackPath.toString();
    }

    private String[] resolveUploadLocations() {
        List<String> locations = new ArrayList<>();
        locations.add(new File(resolveUploadDir()).toURI().toString());
        locations.add(new File(Paths.get(System.getProperty("user.dir"), "src", "main", "webapp", "uploads").toString()).toURI().toString());
        locations.add(new File(Paths.get(System.getProperty("user.home"), "shaheed-uploads").toString()).toURI().toString());
        return locations.toArray(new String[0]);
    }
}