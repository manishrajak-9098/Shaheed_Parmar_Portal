<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section"><div class="sidebar-label">Main</div><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Applications</div><a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a><a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link">All Applications</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Records</div><a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a><a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a></div>
     <div>
    <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link">
   <i class="fas fa-users"></i> Registered Families
</a>
</div>
    <div class="sidebar-section"><div class="sidebar-label">Others</div><a href="${pageContext.request.contextPath}/admin/feedback" class="sidebar-link active">User Feedback</a></div>
    <div class="sidebar-section"><a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a></div>
  </aside>

  <main class="admin-main">
    <div class="page-header flex-between">
      <div>
        <div class="page-title">User Feedback</div>
        <div class="page-sub">All feedback submitted by portal users</div>
      </div>
      <div class="bold" style="font-size:20px;">Total: <%= feedbacks != null ? feedbacks.size() : 0 %></div>
    </div>

    <% if(feedbacks == null || feedbacks.isEmpty()){ %>
    <div class="card text-center"><p class="muted">No users have submitted feedback so far.</p></div>
    <% } else { %>
    <div class="card" style="padding:0">
      <div class="table-wrap">
        <table class="data-table">
          <thead><tr><th>#</th><th>Name</th><th>Email</th><th>Message</th></tr></thead>
          <tbody>
            <% int i = 1; for(Feedback fb : feedbacks){ %>
            <tr>
              <td><%= i++ %></td>
              <td class="bold"><%= fb.getName() != null ? fb.getName() : "-" %></td>
              <td class="muted"><%= fb.getEmail() != null && !fb.getEmail().isEmpty() ? fb.getEmail() : "—" %></td>
              <td><%= fb.getMessage() != null ? fb.getMessage() : "-" %></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
    <% } %>
  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>