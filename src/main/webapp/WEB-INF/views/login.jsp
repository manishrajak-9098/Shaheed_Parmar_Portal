<%@ include file="layout/navbar.jsp" %>
<div class="auth-wrap">
  <div class="auth-box">
    <div class="auth-title">Family Login</div>
    <div class="auth-sub">Sign in to access your welfare dashboard</div>

    <% if(request.getAttribute("error")!=null){ %>
    <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
    <% } %>
    <% if(request.getAttribute("success")!=null){ %>
    <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
    <% } %>
    <% if(request.getAttribute("info")!=null){ %>
    <div class="alert alert-info"><i class="fas fa-info-circle"></i> ${info}</div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="form-group">
        <label>Email Address</label>
        <input type="email" name="email" placeholder="your@email.com" required autofocus>
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" placeholder="Enter your password" required>
      </div>
      <button type="submit" class="btn btn-gold" style="width:100%; justify-content:center;">
        <i class="fas fa-sign-in-alt"></i> Login to Portal
      </button>
    </form>

    <div class="auth-divider"><span>or</span></div>
    <p class="text-sm text-center muted">
      New family? <a href="${pageContext.request.contextPath}/register" class="bold">Register Here</a>
    </p>
    <p class="text-sm text-center muted mt-16">
      Admin? <a href="${pageContext.request.contextPath}/admin/login" class="bold">Admin Login</a>
    </p>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>