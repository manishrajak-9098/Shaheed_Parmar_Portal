<%@ include file="layout/navbar.jsp" %>
<div class="page-wrap">
  <button class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/'">
    <i class="fas fa-arrow-left"></i> Back to Home
  </button>
  <div class="page-header">
    <div class="page-title"><i class="fas fa-info-circle"></i> About This Portal</div>
    <div class="page-sub">Mission, vision and services of Shaheed Parmar Portal</div>
  </div>

  <div class="card">
    <div class="card-title"><i class="fas fa-flag"></i> Our Mission</div>
    <p>
      The <strong>Shaheed Parmar Portal</strong> is a dedicated government welfare system designed to honour
      the families of soldiers who made the supreme sacrifice for our nation. We ensure that every entitled benefit -
      pension, employment, education, housing, and medical care - reaches the family with zero bureaucratic hurdles
      and complete digital transparency.
    </p>
  </div>

  <div class="card">
    <div class="card-title"><i class="fas fa-hand-holding-heart"></i> Benefits Available</div>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:16px">
      <div class="card" style="margin:0; box-shadow:none;">
        <div class="bold mb-16"><i class="fas fa-coins"></i> One-Time Pension</div>
        <p class="text-sm muted">Lump-sum pension payment as per government norms disbursed to the registered family.</p>
      </div>
      <div class="card" style="margin:0; box-shadow:none;">
        <div class="bold mb-16"><i class="fas fa-calendar-check"></i> Monthly Pension</div>
        <p class="text-sm muted">Regular monthly pension to ensure financial stability of the martyr's family.</p>
      </div>
      <div class="card" style="margin:0; box-shadow:none;">
        <div class="bold mb-16"><i class="fas fa-briefcase"></i> Job Reservation</div>
        <p class="text-sm muted">Priority government job reservation for one eligible member.</p>
      </div>
      <div class="card" style="margin:0; box-shadow:none;">
        <div class="bold mb-16"><i class="fas fa-hospital"></i> Medical Benefits</div>
        <p class="text-sm muted">Free medical treatment at government hospitals for the immediate family.</p>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-title"><i class="fas fa-list-ol"></i> Application Process</div>
    <div class="progress-steps">
      <div class="step done">Register</div>
      <div class="step done">Shaheed Details</div>
      <div class="step done">Upload Docs</div>
      <div class="step active">Admin Verify</div>
      <div class="step">Benefits</div>
    </div>
  </div>

  <div class="card">
    <div class="card-title"><i class="fas fa-phone"></i> Contact</div>
    <p class="text-sm muted"><i class="fas fa-envelope"></i> &nbsp;welfare@shaheedportal.gov.in</p>
    <p class="text-sm muted mt-16"><i class="fas fa-phone"></i> &nbsp;1800-XXX-XXXX (Toll Free, Mon-Sat 9AM:5PM)</p>
    <p class="text-sm muted mt-16"><i class="fas fa-map-marker-alt"></i> &nbsp;Ministry of Defence, Welfare Wing, New Delhi - 110001</p>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>