<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  List<Application> apps = (List<Application>) request.getAttribute("applications");
  List<FamilyUser>  fams = (List<FamilyUser>)  request.getAttribute("families");
  List<Shaheed>     shas = (List<Shaheed>)     request.getAttribute("shaheeds");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section"><div class="sidebar-label">Main</div><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Applications</div><a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link active">Pending Verification</a><a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link">All Applications</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Records</div><a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a><a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a></div>
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
      <div class="page-title">Application Verification</div>
      <div class="page-sub">Review pending applications and verify or reject them</div>
    </div>

    <% if(request.getAttribute("msg") != null){ %><div class="alert alert-success">${msg}</div><% } %>

    <% if(apps == null || apps.isEmpty()){ %>
    <div class="card text-center"><p class="muted">No pending applications at the moment.</p></div>
    <% }else{
         for(Application a : apps){
           String fName="-",fEmail="-",fMobile="-",fRelation="-",fCity="-",sName="-",sRank="-",sService="-",sUnit="-";
           if(fams!=null) for(FamilyUser f:fams){ if(f.getId().equals(a.getFamilyUserId())){ fName=f.getName(); fEmail=f.getEmail(); fMobile=f.getMobile()!=null?f.getMobile():"-"; fRelation=f.getRelationWithShaheed()!=null?f.getRelationWithShaheed():"-"; fCity=(f.getCity()!=null?f.getCity():"")+(f.getState()!=null?", "+f.getState():""); break; } }
           if(shas!=null) for(Shaheed s:shas){ if(s.getId().equals(a.getShaheedId())){ sName=s.getName(); sRank=s.getRank()!=null?s.getRank():"-"; sService=s.getServiceNumber()!=null?s.getServiceNumber():"-"; sUnit=s.getArmyUnit()!=null?s.getArmyUnit():"-"; break; } }
    %>
    <div class="card">
      <div class="flex-between mb-16 border-bottom pb-10">
        <div><span class="bold">#APP-<%= String.format("%05d", a.getId()) %></span> <span class="badge badge-pending">PENDING</span></div>
        <span class="text-xs muted">Submitted: <%= a.getSubmissionDate()!=null?a.getSubmissionDate().toString().substring(0,10):"" %></span>
      </div>

      <div class="form-row mb-16">
        <div class="p-16 border rounded bg-light">
          <div class="form-section-title mt-0">Family Member</div>
          <p class="bold"><%= fName %></p>
          <p class="text-xs muted">Relation: <%= fRelation %> | <%= fEmail %> | <%= fMobile %></p>
        </div>
        <div class="p-16 border rounded bg-light">
          <div class="form-section-title mt-0">Shaheed</div>
          <p class="bold"><%= sName %></p>
          <p class="text-xs muted">Rank: <%= sRank %> | Service No: <%= sService %> | Unit: <%= sUnit %></p>
        </div>
      </div>

      <div class="bg-light p-16 border rounded">
        <form action="${pageContext.request.contextPath}/admin/verify" method="post">
          <input type="hidden" name="appId" value="<%= a.getId() %>">
          <div class="form-group">
            <label>Admin Remarks (shown to family)</label>
            <input type="text" name="remarks" placeholder="e.g. Documents verified / incomplete...">
          </div>
          <div style="display:flex;gap:10px;">
            <button type="submit" name="action" value="VERIFY" class="btn btn-green">Verify Application</button>
            <button type="submit" name="action" value="REJECT" class="btn btn-danger">Reject</button>
            <% if(a.getFamilyUserId() != null){ %><a href="${pageContext.request.contextPath}/admin/family/<%= a.getFamilyUserId() %>" class="btn btn-outline">Full Profile</a><% } %>
          </div>
        </form>
      </div>
    </div>
    <% }} %>
  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>