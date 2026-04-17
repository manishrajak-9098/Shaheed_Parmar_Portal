<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  List<Application> apps     = (List<Application>) request.getAttribute("applications");
  List<FamilyUser>  families = (List<FamilyUser>)  request.getAttribute("families");
  List<Shaheed>     shaheeds = (List<Shaheed>)     request.getAttribute("shaheeds");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section"><div class="sidebar-label">Main</div><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Applications</div><a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a><a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link active">All Applications</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Records</div><a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a><a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a></div>
    <div><a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link">
   <i class="fas fa-users"></i> Registered Families
</a>
</div>
    <div class="sidebar-section"><div class="sidebar-label">Others</div><a href="${pageContext.request.contextPath}/admin/feedback" class="sidebar-link">User Feedback</a></div>
    <div class="sidebar-section"><a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a></div>
  </aside>

  <main class="admin-main">
    <div class="page-header flex-between">
      <div>
        <div class="page-title">All Applications</div>
        <div class="page-sub">Complete list of all submitted family welfare applications</div>
      </div>
      <div class="bold" style="font-size:20px;">Total: <%= apps != null ? apps.size() : 0 %></div>
    </div>

    <% if(request.getAttribute("msg") != null){ %><div class="alert alert-success">${msg}</div><% } %>

    <div class="filter-bar">
      <input type="text" id="searchInput" placeholder="Search by name, App ID..." style="min-width:220px" oninput="filterTable()">
      <select id="statusFilter" onchange="filterTable()">
        <option value="">All Statuses</option>
        <option value="PENDING">Pending</option>
        <option value="VERIFIED">Verified</option>
        <option value="REJECTED">Rejected</option>
      </select>
    </div>

    <div class="card" style="padding:0">
      <div class="table-wrap">
        <table class="data-table" id="appTable">
          <thead>
            <tr><th>#</th><th>App ID</th><th>Family Name</th><th>Shaheed</th><th>Submitted</th><th>Status</th><th>Verified On</th><th>Actions</th></tr>
          </thead>
          <tbody>
            <% if(apps == null || apps.isEmpty()){ %>
            <tr><td colspan="8" class="text-center muted">No applications found.</td></tr>
            <% }else{
                 int i=1;
                 for(Application a : apps){
                   String fn="N/A", sn="N/A";
                   if(families!=null) for(FamilyUser f:families){ if(f.getId().equals(a.getFamilyUserId())){fn=f.getName();break;} }
                   if(shaheeds!=null) for(Shaheed s:shaheeds){ if(s.getId().equals(a.getShaheedId())){sn=s.getName();break;} }
            %>
            <tr data-name="<%= fn.toLowerCase() %>" data-appid="<%= a.getId() %>" data-status="<%= a.getVerificationStatus() %>">
              <td><%= i++ %></td>
              <td class="bold">#APP-<%= String.format("%05d", a.getId()) %></td>
              <td><% if(a.getFamilyUserId()!=null){ %><a href="${pageContext.request.contextPath}/admin/family/<%= a.getFamilyUserId() %>"><%= fn %></a><% }else{ %><%= fn %><% } %></td>
              <td><%= sn %></td>
              <td><%= a.getSubmissionDate()!=null?a.getSubmissionDate().toString().substring(0,10):"" %></td>
              <td><span class="badge badge-<%= a.getVerificationStatus().toLowerCase() %>"><%= a.getVerificationStatus() %></span></td>
              <td><%= a.getVerifiedDate()!=null?a.getVerifiedDate().toString().substring(0,10):"—" %></td>
              <td>
                <div style="display:flex;gap:6px;">
                  <% if("VERIFIED".equals(a.getVerificationStatus())){ %><a href="${pageContext.request.contextPath}/admin/allocate/<%= a.getId() %>" class="btn btn-gold btn-xs">Benefits</a>
                  <% }else if("PENDING".equals(a.getVerificationStatus())){ %><a href="${pageContext.request.contextPath}/admin/verification" class="btn btn-outline btn-xs">Review</a><% } %>
                  <% if(a.getFamilyUserId()!=null){ %><a href="${pageContext.request.contextPath}/admin/family/<%= a.getFamilyUserId() %>" class="btn btn-outline btn-xs">Profile</a><% } %>
                </div>
              </td>
            </tr>
            <% }} %>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>
<script>
function filterTable() {
  var search = document.getElementById('searchInput').value.toLowerCase();
  var status = document.getElementById('statusFilter').value;
  document.querySelectorAll('#appTable tbody tr[data-name]').forEach(function(row) {
    var name   = row.getAttribute('data-name')   || '';
    var appid  = row.getAttribute('data-appid')  || '';
    var rStatus= row.getAttribute('data-status') || '';
    var matchSearch = name.includes(search) || appid.includes(search);
    var matchStatus = !status || rStatus === status;
    row.style.display = (matchSearch && matchStatus) ? '' : 'none';
  });
}
</script>
<%@ include file="layout/admin-footer.jsp" %>