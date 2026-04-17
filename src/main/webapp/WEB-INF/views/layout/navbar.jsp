<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shaheed Parmar Portal</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<nav class="navbar">
  <div class="nav-brand">
    <div class="nav-emblem">&#9774;</div>
    <div>
      <div class="brand-text">SHAHEED PARMAR PORTAL</div>
      <div class="brand-sub">Jai Hind &nbsp;|&nbsp; Vande Mataram</div>
    </div>
  </div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a>
    <a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> About</a>
    <a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a>
    <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Family Login</a>
    <a href="${pageContext.request.contextPath}/feedback"><i class="fas fa-comment"></i> Feedback</a>
    <a href="${pageContext.request.contextPath}/admin/login" class="admin-link">
      <i class="fas fa-shield-alt"></i> Admin
    </a>
  </div>
</nav>