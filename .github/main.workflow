workflow "on push" {
  on = "push"
  resolves = ["yamllint"]
}

# Used for fix on review
# Don't enable if you plan using autofix on push
# Or there might be race conditions
workflow "on review" {
  resolves = ["yamllint"]
  on = "pull_request_review"
}

action "yamllint" {
  uses = "bltavares/actions/yamllint@master"
  # Enable autofix on push
  # args = ["autofix"]
  # Used for pushing changes for `fix` comments on review
  secrets = ["c36390e7624c89c24f8e022b593ed9819bc77094"]
}
    