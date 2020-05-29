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
  secrets = ["8b1ee6f8f0b5b478f012e9c96f3d58142c58e06b"]
}
    