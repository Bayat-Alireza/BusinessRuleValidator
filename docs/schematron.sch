<?xml version="1.0"?>

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema">

 <sch:pattern id="Applicant">
    <sch:let name="publishedDate" value="Package/Publisher/@PublishedDateTime"/>
   <!-- some comment -->
   <sch:rule context="Package/Content/Application/PersonApplicant">
      <!-- Checking whether the applicant is at least 18 years old at the time of application submission  -->
      
      <sch:assert test=
      "(substring-before($publishedDate,'-') - substring-before(./@DateOfBirth,'-') &gt; 18
      or (
        substring-before($publishedDate,'-') - substring-before(./@DateOfBirth,'-') = 18
        and substring-before(substring-after($publishedDate,'-'),'-') &gt; substring-before(substring-after(./@DateOfBirth,'-'),'-'))
        )

      or (
        substring-before($publishedDate,'-') - substring-before(./@DateOfBirth,'-') = 18 
        and (
          substring-before(substring-after($publishedDate,'-'),'-') = substring-before(substring-after(./@DateOfBirth,'-'),'-')
          )
        and (
          substring-before(substring-after(substring-after($publishedDate,'-'),'-'),'T') &gt; substring-after(substring-after(./@DateOfBirth,'-'),'-')
          )
      )"
      >Person applicant must be at least 18 years old at the time of application submission.</sch:assert>
      <sch:assert test="year-from-dateTime($publishedDate)>20200">year from data time function <sch:value-of select="year-from-dateTime($publishedDate)"/></sch:assert>
      <!-- <sch:assert test="xs:dateTime($publishedDate)-xs:dateTime(./@DateOfBirth)>5000000000">Applicant <sch:value-of select="year-from-dateTime(./@DateOfBirth)"/> must be 18</sch:assert> -->
    </sch:rule>
    
  </sch:pattern>

  <sch:pattern id="Application">
    <sch:let name="CompanyApplicantContact" value="Package/Content/Application/CompanyApplicant/Contact"/>
    <sch:let name="PersonApplicantContact" value="Package/Content/Application/PersonApplicant/Contact"/>
    <sch:let name="TrustApplicantContact" value="Package/Content/Application/TrustApplicant/Contact"/>
    
   <!-- some comment -->
   <sch:rule context="Package/Content/Application">
      <!-- Checking whether the applicant's Contact element is populated  -->
      <sch:assert test=" $CompanyApplicantContact | $PersonApplicantContact | $TrustApplicantContact">Applicant must have 'Contact' element.</sch:assert>
      <!-- Checking whether The Person Applicant current address element is populated -->
      <sch:assert test=" not($PersonApplicantContact) or $PersonApplicantContact/CurrentAddress">Person Applicant must have 'CurrentAddress' element populated.</sch:assert>
      <!-- Checking whether the ContactPerson element populated for a Company or Trust applicant,    -->
      <sch:assert test=" not($CompanyApplicantContact) and not($TrustApplicantContact ) or $CompanyApplicantContact/ContactPerson | $TrustApplicantContact/ContactPerson">Company or Trust Applicant must have 'ContactPerson' element populated.</sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern id="Contact">
    <sch:let name="Address" value="Package/Content/Application/Address/@UniqueID"/>
   <!-- some comment -->
   <sch:rule context="Package/Content/Application/PersonApplicant/Contact/CurrentAddress">
      <!-- Checking whether x_Mailing and x_Residential attributes are populated   -->
      <sch:assert test="./@x_MailingAddress and ./@x_ResidentialAddress">A person applicant must have a mailing address and residential address.</sch:assert>
      <!-- Checking whether x_ResidentialAddress and x_MailingAddress are corresponding to a valid Address element-->
      <sch:assert test="$Address = ./@x_MailingAddress and $Address=./@x_ResidentialAddress">A person applicant must have a valid residential and mailing address.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern id="Employment">
   <!-- some comment -->
   <sch:rule context="Package/Content/Application/PersonApplicant/Employment/PAYG/Income">
      <!-- Checking the income element has both the fringe and the frequency of the fringe ) -->
      
      <sch:assert test="not(@CarAllowanceAmount) and not(@CarAllowanceFrequency) 
                        or (@CarAllowanceAmount and @CarAllowanceFrequency)">If there is a car allowance amount there must be a car allowance frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@CommissionAmount) and not(@CommissionFrequency) 
                        or (@CommissionAmount and @CommissionFrequency)">If there is a commission amount there must be a commission frequency as well.</sch:assert>
      <sch:assert test="not(@WorkAllowanceAmount) and not(@WorkAllowanceFrequency) 
                        or (@WorkAllowanceAmount and @WorkAllowanceFrequency)">If there is a work allowance amount there must be a work allowance frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@WorkersCompensationAmount) and not(@WorkersCompensationFrequency) 
                        or (@WorkersCompensationAmount and @WorkersCompensationFrequency)">If there is a work compensation amount there must be a work compensatino frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@OtherFringeBenefitAmount) and not(@OtherFringeBenefitFrequency) 
                        or (@OtherFringeBenefitAmount and @OtherFringeBenefitFrequency)">If there is other fringe benefit amount there must be other fringe benefit frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetWorkersCompensationAmount) and not(@NetWorkersCompensationFrequency) 
                        or (@NetWorkersCompensationAmount and @NetWorkersCompensationFrequency)">If there is net worker compensation amount there must be net worker compensation frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetWorkAllowanceAmount) and not(@NetWorkAllowanceFrequency) 
                        or (@NetWorkAllowanceAmount and @NetWorkAllowanceFrequency)">If there is net work allowance amount there must be net work allowance frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetSalaryAmount) and not(@NetSalaryFrequency) 
                        or (@NetSalaryAmount and @NetSalaryFrequency)">If there is net salary amount there must be net salary frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetRegularOvertimeAmount) and not(@NetRegularOvertimeFrequency) 
                        or (@NetRegularOvertimeAmount and @NetRegularOvertimeFrequency)">If there is net regular over time amount there must be net regular over time frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetCommissionAmount) and not(@NetCommissionFrequency) 
                        or (@NetCommissionAmount and @NetCommissionFrequency)">If there is net commission amount there must be net commission frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetCarAllowanceAmount) and not(@NetCarAllowanceFrequency) 
                        or (@NetCarAllowanceAmount and @NetCarAllowanceFrequency)">If there is net car allowance amount there must be net car allowance frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@NetBonusAmount) and not(@NetBonusFrequency) 
                        or (@NetBonusAmount and @NetBonusFrequency)">If there is net bonus amount there must be net bonus frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@GrossSalaryAmount) and not(@GrossSalaryFrequency) 
                        or (@GrossSalaryAmount and @GrossSalaryFrequency)">If there is gross salary amount there must be gross salary frequency as well or vice versa.</sch:assert>
      <sch:assert test="not(@GrossRegularOvertimeAmount) and not(@GrossRegularOvertimeFrequency) 
                        or (@GrossRegularOvertimeAmount and @GrossRegularOvertimeFrequency)">If there is gross salary overtime amount there must be gross salary overtime frequency as well or vice versa.</sch:assert>
      
    </sch:rule>
  </sch:pattern>
    <sch:pattern id="NumberOfEmployment">
   <sch:rule context="Package/Content/Application/PersonApplicant/Employment">
      <!-- Checking employment element has only one element and the sequence number attribute  -->
        <sch:assert test="@SequenceNumber and count(./*)=1">Employment must only have one type of employment and a sequence number.</sch:assert>

    </sch:rule>
  </sch:pattern>
</sch:schema>
