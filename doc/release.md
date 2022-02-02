# How to release

* Version up: update `metadata.rb`
* Update Changelog: `github_changelog_generator -u elastic-infra -p chrony_ii --future-release v0.5.2`
* Commit changes above
* Release cookbook: `chef exec stove`
