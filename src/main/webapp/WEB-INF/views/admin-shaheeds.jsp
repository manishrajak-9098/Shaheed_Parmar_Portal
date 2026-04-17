<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  List<Shaheed> shaheedList = (List<Shaheed>) request.getAttribute("shaheeds");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section"><div class="sidebar-label">Main</div><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Applications</div><a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a><a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link">All Applications</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Records</div><a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link active">Shaheed Records</a><a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a></div>
     <div>
    <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link">
   <i class="fas fa-users"></i>Registered Families
</a>
</div>
    <div class="sidebar-section"><div class="sidebar-label">Others</div><a href="${pageContext.request.contextPath}/admin/feedback" class="sidebar-link">User Feedback</a></div>
    <div class="sidebar-section"><a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a></div>
  </aside>

  <main class="admin-main">
    <div class="page-header">
      <div class="page-title">Martyrs (Shaheed) Database</div>
      <div class="page-sub">Complete record of all registered Shaheeds</div>
    </div>

    <div class="card" style="padding:0;">
      <div class="table-wrap">
        <table class="data-table">
          <thead><tr><th>SERVICE NO</th><th>RANK & NAME</th><th>UNIT/REGIMENT</th><th>MARTYRDOM DATE</th><th>PLACE</th></tr></thead>
          <tbody>
            <% if(shaheedList != null && !shaheedList.isEmpty()) { for(Shaheed s : shaheedList) { %>
            <tr>
              <td><%= s.getServiceNumber() %></td>
              <td class="bold"><%= s.getRank() %> <%= s.getName() %></td>
              <td><%= s.getArmyUnit() %></td>
              <td><%= s.getMartyrdomDate() %></td>
              <td><%= s.getPlaceOfMartyrdom() %></td>
            </tr>
            <% } } else { %>
              <tr><td colspan="5" class="text-center muted">No martyr records available.</td></tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>