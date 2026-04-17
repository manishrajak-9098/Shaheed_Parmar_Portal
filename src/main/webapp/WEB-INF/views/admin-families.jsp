<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>

<div class="admin-layout">
  <!-- Sidebar -->
  <aside class="admin-sidebar">
    <div class="sidebar-section">
      <div class="sidebar-label">Main</div>
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
      <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link active">Registered Families</a>
    </div>
    <div class="sidebar-section">
      <div class="sidebar-label">Applications</div>
      <a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a>
      <a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link">All Applications</a>
    </div>
    <div class="sidebar-section">
      <div class="sidebar-label">Records</div>
      <a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a>
      <a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a>
    </div>
    
    <div class="sidebar-section">
      <a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="admin-main">
    <div class="page-header flex-between">
      <div>
        <div class="page-title">Registered Families</div>
        <div class="page-sub">Portal par registered sabhi parivaron ki suchi (Total Data)</div>
      </div>
      <div class="bold" style="font-size:20px;">
        Total: <%= ((List)request.getAttribute("families")).size() %>
      </div>
    </div>

    <div class="card" style="padding:0">
      <div class="table-wrap">
        <table class="data-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Full Name</th>
              <th>Email</th>
              <th>Mobile</th>
              <th>Relation</th>
              <th>City / State</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <% 
              List<FamilyUser> families = (List<FamilyUser>) request.getAttribute("families");
              int i = 1;
              if(families != null) {
                for(FamilyUser f : families) {
            %>
            <tr>
              <td><%= i++ %></td>
              <td class="bold"><%= f.getName() %></td>
              <td><%= f.getEmail() %></td>
              <td><%= f.getMobile() != null ? f.getMobile() : "-" %></td>
              <td><%= f.getRelationWithShaheed() != null ? f.getRelationWithShaheed() : "-" %></td>
              <td><%= f.getCity() %> / <%= f.getState() %></td>
              <td>
                <span class="badge badge-<%= f.getStatus().toLowerCase() %>">
                  <%= f.getStatus() %>
                </span>
              </td>
              <td>
                <a href="${pageContext.request.contextPath}/admin/family/<%= f.getId() %>" class="btn btn-outline btn-xs">View Full Profile</a>
              </td>
            </tr>
            <% 
                }
              } 
            %>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>

<%@ include file="layout/admin-footer.jsp" %>