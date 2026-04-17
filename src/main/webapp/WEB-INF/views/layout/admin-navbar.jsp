<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shaheed Parmar Portal - Admin</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
</head>
<body>
<nav class="navbar">
  <div class="nav-brand">
    <div class="nav-emblem">&#9774;</div>
    <div>
      <div class="brand-text">SHAHEED PARMAR PORTAL</div>
      <div class="brand-sub">Admin Panel &nbsp;|&nbsp; Ministry of Defence</div>
    </div>
  </div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/admin/dashboard">
      <i class="fas fa-tachometer-alt"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/logout" class="admin-link">
      <i class="fas fa-sign-out-alt"></i> Logout
    </a>
  </div>
</nav>