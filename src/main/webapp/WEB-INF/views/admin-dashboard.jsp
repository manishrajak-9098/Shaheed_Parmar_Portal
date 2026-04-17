<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  long total    = (Long) request.getAttribute("totalApps");
  long pending  = (Long) request.getAttribute("pendingCount");
  long verified = (Long) request.getAttribute("verifiedCount");
  long rejected = (Long) request.getAttribute("rejectedCount");
  int  families = ((List) request.getAttribute("families")).size();
  int  shaheeds = ((List) request.getAttribute("shaheeds")).size();
  List<Application> recentApps  = (List<Application>) request.getAttribute("recentApps");
  List<FamilyUser>  familyList  = (List<FamilyUser>)  request.getAttribute("families");
  List<Shaheed>     shaheedList = (List<Shaheed>)     request.getAttribute("shaheeds");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section">
      <div class="sidebar-label">Main</div>
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">Dashboard</a>
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
    <div class="flex-between mb-24">
      <div>
        <div class="page-title">Admin Dashboard</div>
        <div class="page-sub">Welcome, <strong><%= admin.getFullName()!=null?admin.getFullName():admin.getUsername() %></strong></div>
      </div>
      <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm">Logout</a>
    </div>

    <div class="stats-grid">
      <div class="stat-card"><div class="big-num"><%= total %></div><span class="s-label">Total Applications</span></div>
      <div class="stat-card"><div class="big-num text-warning"><%= pending %></div><span class="s-label">Pending Review</span></div>
      <div class="stat-card"><div class="big-num text-success"><%= verified %></div><span class="s-label">Verified</span></div>
      <div class="stat-card"><div class="big-num text-danger"><%= rejected %></div><span class="s-label">Rejected</span></div>
      <div class="stat-card"><div class="big-num text-info"><%= families %></div><span class="s-label">Registered Families</span></div>
      <div class="stat-card"><div class="big-num"><%= shaheeds %></div><span class="s-label">Shaheed Records</span></div>
    </div>

    <div class="card">
      <div class="card-title">Recent Applications</div>
      <div class="table-wrap">
        <table class="data-table">
          <thead>
            <tr><th>#</th><th>App ID</th><th>Family</th><th>Shaheed</th><th>Submitted</th><th>Status</th><th>Action</th></tr>
          </thead>
          <tbody>
            <% int rn=1; if(recentApps!=null){ int max=Math.min(recentApps.size(),10); for(int i=0;i<max;i++){
               Application a=recentApps.get(i);
               String fn="N/A", sn="N/A";
               if(familyList!=null) for(FamilyUser f:familyList){ if(f.getId().equals(a.getFamilyUserId())){fn=f.getName();break;} }
               if(shaheedList!=null) for(Shaheed s:shaheedList){ if(s.getId().equals(a.getShaheedId())){sn=s.getName();break;} }
            %>
            <tr>
              <td><%= rn++ %></td>
              <td class="bold">#APP-<%= String.format("%05d",a.getId()) %></td>
              <td><%= fn %></td><td><%= sn %></td>
              <td><%= a.getSubmissionDate()!=null?a.getSubmissionDate().toString().substring(0,10):"" %></td>
              <td><span class="badge badge-<%= a.getVerificationStatus().toLowerCase() %>"><%= a.getVerificationStatus() %></span></td>
              <td>
                <% if("VERIFIED".equals(a.getVerificationStatus())){ %><a href="${pageContext.request.contextPath}/admin/allocate/<%= a.getId() %>" class="btn btn-gold btn-xs">Benefits</a>
                <% }else if("PENDING".equals(a.getVerificationStatus())){ %><a href="${pageContext.request.contextPath}/admin/verification" class="btn btn-outline btn-xs">Review</a><% } %>
              </td>
            </tr>
            <% }} %>
          </tbody>
        </table>
      </div>
      <div class="mt-16"><a href="${pageContext.request.contextPath}/admin/applications" class="btn btn-outline btn-sm">View All</a></div>
    </div>
  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>