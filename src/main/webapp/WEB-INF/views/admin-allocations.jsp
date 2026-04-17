<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  List<FacilityAllocation> allocations = (List<FacilityAllocation>) request.getAttribute("allocations");
  List<FamilyUser>  families  = (List<FamilyUser>)  request.getAttribute("families");
  List<Facility>    facilities = (List<Facility>)   request.getAttribute("facilities");

  long activeCnt = 0;
  Set<Long> uniqueFam = new HashSet<>();
  if(allocations != null){
    for(FacilityAllocation fa : allocations){
      if("ACTIVE".equals(fa.getStatus())) activeCnt++;
      if(fa.getFamilyUserId() != null) uniqueFam.add(fa.getFamilyUserId());
    }
  }
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section">
      <div class="sidebar-label">Main</div>
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
    </div>
    <div class="sidebar-section">
      <div class="sidebar-label">Applications</div>
      <a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a>
      <a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link">All Applications</a>
    </div>
    <div class="sidebar-section">
      <div class="sidebar-label">Records</div>
      <a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a>
      <a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link active">Benefit Allocations</a>
    </div>
    <div>
    <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link">
   <i class="fas fa-users"></i> Registered Families
</a>
</div>
    <div class="sidebar-section">
      <div class="sidebar-label">Others</div>
      <a href="${pageContext.request.contextPath}/admin/feedback" class="sidebar-link">User Feedback</a>
    </div>
    <div class="sidebar-section">
      <a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a>
    </div>
  </aside>

  <main class="admin-main">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">
      <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

    <div class="page-header">
      <div class="page-title">Benefit Allocation History</div>
      <div class="page-sub">Complete record of all benefits allocated to martyrs' families</div>
    </div>

    <!-- Summary Stats -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="big-num text-success"><%= allocations != null ? allocations.size() : 0 %></div>
        <span class="s-label">Total Allocations</span>
      </div>
      <div class="stat-card">
        <div class="big-num text-info"><%= activeCnt %></div>
        <span class="s-label">Active Benefits</span>
      </div>
      <div class="stat-card">
        <div class="big-num"><%= uniqueFam.size() %></div>
        <span class="s-label">Families Benefited</span>
      </div>
    </div>

    <div class="card" style="padding:0">
      <div class="table-wrap">
        <table class="data-table">
          <thead>
            <tr>
              <th>#</th>
              <th>App ID</th>
              <th>Family</th>
              <th>Benefit Name</th>
              <th>Type</th>
              <th>Start Date</th>
              <th>Status</th>
              <th>Remarks</th>
              <th>Allocated On</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <% if(allocations == null || allocations.isEmpty()){ %>
            <tr>
              <td colspan="10" class="text-center muted">
                No benefits have been allocated yet.
              </td>
            </tr>
            <% } else {
                 int i = 1;
                 for(FacilityAllocation fa : allocations){
                   String fName = "N/A";
                   if(families != null && fa.getFamilyUserId() != null)
                     for(FamilyUser f : families){
                       if(f.getId().equals(fa.getFamilyUserId())){fName=f.getName();break;}
                     }
                   String facName = "N/A", facType = "";
                   if(facilities != null && fa.getFacilityId() != null)
                     for(Facility f : facilities){
                       if(f.getId().equals(fa.getFacilityId())){
                         facName = f.getName();
                         facType = f.getFacilityType() != null ? f.getFacilityType() : "";
                         break;
                       }
                     }
            %>
            <tr>
              <td class="text-xs muted"><%= i++ %></td>
              <td class="bold">
                <% if(fa.getApplicationId() != null){ %>
                <a href="${pageContext.request.contextPath}/admin/allocate/<%= fa.getApplicationId() %>">
                  #APP-<%= String.format("%05d", fa.getApplicationId()) %>
                </a>
                <% } else { %>—<% } %>
              </td>
              <td class="bold">
                <% if(fa.getFamilyUserId() != null){ %>
                <a href="${pageContext.request.contextPath}/admin/family/<%= fa.getFamilyUserId() %>">
                  <%= fName %>
                </a>
                <% } else { %><%= fName %><% } %>
              </td>
              <td><strong><%= facName %></strong></td>
              <td><span class="badge badge-gold"><%= facType %></span></td>
              <td><%= fa.getStartDate() != null ? fa.getStartDate() : "TBD" %></td>
              <td><span class="badge badge-active"><%= fa.getStatus() %></span></td>
              <td class="text-xs muted">
                <%= fa.getRemarks()!=null&&!fa.getRemarks().isEmpty() ? fa.getRemarks() : "—" %>
              </td>
              <td class="text-xs muted">
                <%= fa.getAllocatedDate()!=null ? fa.getAllocatedDate().toString().substring(0,10) : "" %>
              </td>
              <td>
                <% if(fa.getApplicationId() != null){ %>
                <a href="${pageContext.request.contextPath}/admin/allocate/<%= fa.getApplicationId() %>" class="btn btn-outline btn-xs">
                  More
                </a>
                <% } %>
              </td>
            </tr>
            <% }} %>
          </tbody>
        </table>
      </div>
    </div>

  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>