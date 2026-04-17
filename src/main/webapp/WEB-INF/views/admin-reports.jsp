<%@ include file="layout/admin-navbar.jsp" %>
<div class="auth-wrap">
  <div class="auth-box">
    
    <div class="auth-title">Admin Login</div>
    <div class="auth-sub">Secure access for authorized administrators only</div>

    <% if(request.getAttribute("error")!=null){ %>
    <div class="alert alert-error">${error}</div>
    <% } %>
    <% if(request.getAttribute("info")!=null){ %>
    <div class="alert alert-info">${info}</div>
    <% } %>

    <form action="${pageContext.request.contextPath}/admin/login" method="post">
      <div class="form-group">
        <label>Username</label>
        <input type="text" name="username" placeholder="Admin username" required autofocus>
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" placeholder="Admin password" required>
      </div>
      <button type="submit" class="btn btn-gold" style="width:100%; justify-content:center;">
        <i class="fas fa-sign-in-alt"></i> Admin Login
      </button>
    </form>

    <div class="auth-divider"><span>or</span></div>
    <p class="text-sm text-center muted">
      <a href="${pageContext.request.contextPath}/" class="bold"><i class="fas fa-home"></i> Go to Portal Home</a>
    </p>
  </div>
</div>
<%@ include file="layout/admin-footer.jsp" %>