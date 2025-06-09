---
title: "Check Point Automagic, June 2025"
description: "Slides for the workshop"
---
# Check Point Automagic
## June 2025

---
---
## Agenda
<br/>

* Azure Service Principal - enable automation talking to Azure
* `make management` using current [CGNS Terraform modules](https://github.com/CheckPointSW/terraform-azure-cloudguard-network-security)
* `make policy` using Check Point Management [Terraform Provider](https://registry.terraform.io/providers/CheckPointSW/checkpoint/latest/docs)
* `make vmss` using current [CGNS Terraform modules](https://github.com/CheckPointSW/terraform-azure-cloudguard-network-security/tree/master/modules/vmss_new_vnet#usage)
* `make cme` enable Check Point Security Management to auto-provision VMSS instances  
   on scale-in/scale-out events using [CME](https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CME/Content/Topics-CME/Overview.htm?tocpath=_____2)
* `make linux` sample application server deployment using Terraform
    * `make fwon` enable CGNS VMSS protection of app
    * `make fwoff` disable CGNS VMSS protection

---
src: ../azure-sp/slides.md
---

<!-- this page will be loaded from '../azure-sp/slides.md' -->

Contents here are ignored

---
src: ../management/slides.md
---

<!-- this page will be loaded from '../management/slides.md' -->

Contents here are ignored

---
src: ../policy/slides.md
---
<!-- this page will be loaded from '../policy/slides.md' -->

Contents here are ignored

---
layout: cover
---
# Data-drivern policy
## https://github.com/mkol5222/dd-cp-policy
---
layout: image
image: dd-policy.svg
---


---
src: ../vmss/slides.md
---

<!-- this page will be loaded from '../vmss/slides.md' -->

Contents here are ignored
---
---
# Resources

* Check Point [CGNS Azure Terraform modules](https://github.com/CheckPointSW/terraform-azure-cloudguard-network-security)
* Check Point [Management API reference](https://sc1.checkpoint.com/documents/latest/APIs/index.html#)
* Check Point [Management Terraform Provider](https://registry.terraform.io/providers/CheckPointSW/checkpoint/latest/docs)
* SmartTasks documentation: [admin guide](https://sc1.checkpoint.com/documents/R82/WebAdminGuides/EN/CP_R82_SecurityManagement_AdminGuide/Content/Topics-SECMG/SmartTasks.htm)
    * examples [rdarst/SmartTasks](https://github.com/rdarst/SmartTasks)
* CME guide: [admin guide](https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CME/Content/Topics-CME/CME_Structure_and_Configurations.htm)
    * CME gw/management scripts [joe-at-cp/checkpoint-cme-helper](https://github.com/joe-at-cp/checkpoint-cme-helper)
* SmartConsole Extensions [developer guide](https://sc1.checkpoint.com/documents/SmartConsole/)

