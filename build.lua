#!/usr/bin/env texlua

-- Build script for "biblatex-chem" files

-- Identify the bundle and module
bundle = ""
module = "biblatex-chem"

-- Documentation consists of .tex files to typeset plus .bib file to support
-- This needs a little bit of trickery to get the .bib file into the right
-- places
demofiles    = {"*.bib"}
typesetfiles =
  {
    "biblatex-chem.tex",
    "biblatex-chem-acs.tex",
    "biblatex-chem-angew.tex",
    "biblatex-chem-biochem.tex",
    "biblatex-chem-rsc.tex"
  }
supportdir       = "."
typesetsuppfiles = {"*.bib","biblatex-chem-common.tex"}

-- .Nothing to unpack
unpackfiles = { }

-- Install biblatex style files and use these as the sources
installfiles = {"*.cbx", "*.bbx"}
sourcefiles  = installfiles

-- Release a TDS-style zip
packtdszip  = true

-- No tests for this bundle
testfildir = ""

tagfiles = {"*.bbx", "*.cbx", "*.tex"}

function update_tag(file,content,tagname,tagdate)
  local pattern = "%d%d%d%d%-%d%d%-%d%d"
  if string.match(file,"%.tex") then
    content = string.gsub(content,
      "This file describes v?%d%.%d%w?,? last revised " .. pattern, 
      "This file describes " .. tagname .. ", last revised " .. tagdate)
    return string.gsub(content,
      "Released " .. pattern,
      "Released " .. tagdate)
  else
    return string.gsub(content,
      pattern .. " v?%d%.%d%w? biblatex",
     tagdate .. " " .. tagname .. " biblatex")
  end
end

-- Find and run the build system
kpse.set_program_name ("kpsewhich")
if not release_date then
  dofile(kpse.lookup("l3build.lua"))
end
