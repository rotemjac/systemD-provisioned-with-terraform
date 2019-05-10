
variable "git_password" {}

//gitlab.com/rotemjac/santidhamma-website.git
variable "git_repo_path" {}

## 'element' is used in order to take the item 0 (for example) from the result array of the split:
## like you whould write in code: res_arr[0]
locals  {
  git_user         = "${element(split("/",var.git_repo_path),1)}"
  git_repo_postfix = "${element(split("/",var.git_repo_path),2)}"
  git_repo_name    = "${element(split(".",local.git_repo_postfix),0)}"
}