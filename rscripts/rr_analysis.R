# blank = no,  âœ“ = yes ('tick' symbol in csv), TBA = to be announced, TBD = to be decided
"DEFINITIONS OF FEATURES (Note that Criteria 1 and 2 are the minimal necessary conditions to qualify as a Registered Report): 
x1. Includes pre-study peer review: Whether the journal will subject the pre-study proposal to peer review. A pre-study proposal is one evaluated prior to anyone observing study outcomes - usually prior to data collection. 
x2. Offers provisional pre-study acceptance: Whether the journal offers 'in principle acceptance' of proposals, guaranteeing to publish the study regardless of the outcome of the registered hypothesis tests. (Note: satisfying this condition does not require unconditional acceptance).
x3. Permanence of adoption: Whether the journal is offering RRs indefinitely or instead for a trial period or as part of a special issue.
x4. Offered for novel studies: Whether the journal is offering RRs for original studies.
x5. Offered for replication studies: Whether the journal offering RRs for studies seeking to specifically replicate previous research.        
x6. Offered for meta-analysis: Whether the journal will consider RRs that propose meta-analyses.
x7. Offered for analyses of existing data sets: Whether the journal will consider RRs for analysis of data that already exists.
x8. Publishes Registered Reports only: Whether the journal is dedicated solely to publishing Registered Reports.
x9. Allows reporting of unregistered analyses: Whether the RR format allows authors to report unregistered exploratory analyses in the final results (appropriately identified).
x10. Includes post-study peer review: Whether the journal offers peer review of the completed paper following data collection and analysis.
x11. Allows inclusion of unregistered pilot studies: Whether the journal allows authors to include the outcomes of completed pilot experiments within pre-study proposals.
x12. Requires public data deposition: Whether the journal requires authors to publish all relevant data collected as part of the research within a freely accessible repository.
x13. Specifies structured criteria for editorial decisions: Whether the journal specifies the criteria according to which manuscripts will be accepted or rejected at all stages.
x14. Requires submitted protocols to have prior ethical approval: Whether the journal requires authors to have obtained formal ethical approval to conduct the proposed research prior to submission of the pre-study protocol.
x15. Specifies minimum statistical power requirements: Whether the journal guidelines state a minimum threshold for statistical power of pre-registered statistical tests or alternate (e.g. Bayesian) criteria for completion of data collection.
x16. Will publish 'Withdrawn Registrations': Whether the journal will publish a withdrawn registration (including at a minimum the study title, brief study information, and reason for withdrawal) if authors voluntarily remove their study from consideration following the award of provisional acceptance. (Note: does not apply to editorial rejections).
x17. Publishes accepted protocols, in full or part, prior to study completion: Whether the journal publishes any part of the pre-study protocol prior to acceptance of the final manuscript that describes the completed study. This could include anything from the title alone to the full study protocol, and could be on-line only or in its journal pages.
x18. Offers incremental (sequential) registration: Whether the journal gives authors the option of proposing and pre-registering follow-up studies following final acceptance of a completed study, rather than publishing immediately.
x19. Offers incremental addition of unregistered studies: Whether the journal gives authors the option of reporting additional unregistered (exploratory) studies following reporting of the approved pre-registered research.
x20. Offered for qualitative studies.
x21. Requires deposition of the Stage 1 protocol at the point of IPA in a recognised public registry"																		

setwd("C:/Users/zn18986/OneDrive - University of Bristol/Desktop")
rrdata <- read.csv("Comparison of Registered Reports - Sheet1.csv")
prop.table(table(rrdata$X3..Permanence.of.adoption)) # 87% indefinite
prop.table(table(rrdata$X4..Offered.for.novel.studies)) #no 5%, 85% yes
prop.table(table(rrdata$X5..Offered.for.replication.studies)) #7% no, 81% yes
prop.table(table(rrdata$X6..Offered.for.meta.analysis)) #49% no, # 38% yes,
prop.table(table(rrdata$X7..Offered.for.analyses.of.existing.data.sets)) #19% no, 69% yes
prop.table(table(rrdata$X8..Publishes.Registered.Reports.only)) #86% no, 2% yes (n =3)
prop.table(table(rrdata$X9..Allows.reporting.of.unregistered.analyses)) #4% no (n = 8), 85% yes
prop.table(table(rrdata$X10..Includes.post.study.peer.review)) #87% yes, 1%no (n = 1)
prop.table(table(rrdata$X11..Allows.inclusion.of.unregistered.pilot.studies)) #12% no, %76 yes
prop.table(table(rrdata$X12..Requires.public.data.deposition)) #54% no, 34% yes
prop.table(table(rrdata$X13..Specifies.structured.criteria.for.editorial.decisions)) #32% no, 57% yes
prop.table(table(rrdata$X14..Requires.submitted.protocols.to.have.prior.ethical.approval)) #41% no, 46% yes
prop.table(table(rrdata$X15..Specifies.minimum.statistical.power.requirements)) # 49% no, 39% yes
prop.table(table(rrdata$X16..Will.publish.â..Withdrawn.Registrationsâ..)) # 49% no, 40% yes
prop.table(table(rrdata$X17..Publishes.accepted.protocols..in.full.or.part..prior.to.study.completion)) # 60% no, 11% yes, 14% fully published in JMIR protocols, 14% yes in part
prop.table(table(rrdata$X18..Offers.incremental..sequential..registration)) # 35% no, # 52% yes
prop.table(table(rrdata$X19..Offers.incremental.addition.of.unregistered.studies)) # 68% no, #20% yes
prop.table(table(rrdata$X20..Offered.for.qualitative.research)) #82% no, 6% yes, 12% unknown
prop.table(table(rrdata$X21..Requires.deposition.of.protocol.in.public.registry.following.Stage.1.acceptance)) # 45% no, 44% yes