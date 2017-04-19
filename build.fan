#! /usr/bin/env fan
//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   apeterse   Creation
//

using build

**
** Build: midcExt
**
class Build : BuildPod
{
  new make()
  {
    podName = "midcExt"
    summary = "TODO: summary of pod name..."
    version = Version("1.0")
    meta    = [
                "org.name":     "NREL",
                // "org.uri":      "http://acme.com/",
                // "proj.name":    "Project Name",
                // "proj.uri":     "http://acme.com/product/",
                "license.name": "Commercial",
              ]
    depends = ["sys 1.0",
               "haystack 3.0",
               "folio 3.0",
               "axon 3.0",
               "skyarcd 3.0",
               "connExt 3.0",
               "fresco 3.0",
               "inet 1.0",
               "concurrent 1.0"]
    srcDirs = [`fan/`,
               `fan/ui/`]
    resDirs = [`locale/`]
    index   =
    [
      "skyarc.ext": "midcExt::MidcExt",
    ]
  }
}
