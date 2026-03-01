@echo off
set "SRC=%~dp0."
set "DST=C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\MagguuUI"
robocopy "%SRC%" "%DST%" /MIR /XD .git .github .claude /XF CLAUDE.md CHANGELOG.md *.bat *.py *.md .gitignore .gitattributes pkgmeta.yaml
