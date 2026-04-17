<%@ include file="layout/navbar.jsp" %>
<div class="page-wrap" style="max-width:760px">
  <button class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/'">
    <i class="fas fa-arrow-left"></i> Back to Home
  </button>
  <div class="page-header">
    <div class="page-title">Family Registration</div>
    <div class="page-sub">Register to access welfare benefits for your Shaheed's family</div>
  </div>

  <% if(request.getAttribute("error")!=null){ %>
  <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
  <% } %>

  <div class="card">
    <form action="${pageContext.request.contextPath}/register" method="post">
      <div class="form-section-title">Personal Information</div>
      <div class="form-row">
        <div class="form-group"><label>Full Name *</label><input type="text" name="name" required></div>
        <div class="form-group"><label>Date of Birth</label><input type="date" name="dob"></div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Gender *</label>
          <select name="gender" required>
            <option value="">Select Gender</option><option value="Male">Male</option><option value="Female">Female</option><option value="Other">Other</option>
          </select>
        </div>
        <div class="form-group">
          <label>Marital Status</label>
          <select name="maritalStatus">
            <option value="">Select</option><option value="Married">Married</option><option value="Unmarried">Unmarried</option><option value="Widowed">Widowed</option><option value="Divorced">Divorced</option>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group"><label>Aadhaar Number</label><input type="text" name="aadhaarNumber" maxlength="12"></div>
        <div class="form-group">
          <label>Relation With Shaheed *</label>
          <select name="relationWithShaheed" required>
            <option value="">Select Relation</option><option value="Wife">Wife</option><option value="Son">Son</option><option value="Daughter">Daughter</option><option value="Father">Father</option><option value="Mother">Mother</option><option value="Brother">Brother</option><option value="Sister">Sister</option>
          </select>
        </div>
      </div>
      <div class="form-group"><label>Occupation</label><input type="text" name="occupation"></div>

      <div class="form-section-title">Address</div>
      <div class="form-group"><label>Address Line</label><input type="text" name="addressLine"></div>
      <div class="form-row-3">
        <div class="form-group"><label>City</label><input type="text" name="city"></div>
        <div class="form-group"><label>State</label><input type="text" name="state"></div>
        <div class="form-group"><label>Pincode</label><input type="text" name="pincode" maxlength="6"></div>
      </div>

      <div class="form-section-title">Login Credentials</div>
      <div class="form-row">
        <div class="form-group"><label>Email Address *</label><input type="email" name="email" required></div>
        <div class="form-group"><label>Mobile Number *</label><input type="text" name="mobile" maxlength="10" required></div>
      </div>
      <div class="form-row">
        <div class="form-group"><label>Password * (min 6 chars)</label><input type="password" name="password" id="pwd" required minlength="6"></div>
        <div class="form-group"><label>Confirm Password *</label><input type="password" id="cpwd" required></div>
      </div>
      <p id="pwdErr" style="color:var(--danger);font-size:13px;display:none;margin-bottom:12px">Passwords do not match!</p>

      <div style="display:flex;gap:12px;margin-top:20px">
        <button type="submit" class="btn btn-gold">Register Now</button>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Login</a>
      </div>
    </form>
  </div>
</div>
<script>
  document.querySelector('form').addEventListener('submit', function(e) {
    if (document.getElementById('pwd').value !== document.getElementById('cpwd').value) {
      e.preventDefault();
      document.getElementById('pwdErr').style.display = 'block';
    }
  });
</script>
<%@ include file="layout/footer.jsp" %>