locals {
  vm_web = "${var.organisation}-${var.stage_dev}-${var.progect}-${var.vm_type[0]}"
  vm_db = "${var.organisation}-${var.stage_dev}-${var.progect}-${var.vm_type[1]}"
}