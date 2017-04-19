//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   apeterse   Creation
//

using haystack
using connExt
using fresco

**
** MidcApplet
**
@Js
class MidcApplet : ConnApplet
{
  override Bool hasPassword() { true }

  override TagSpec[] connTagSpecs()
  {
    m := Marker.val
    return [
      // hide id/mod
      TagSpec("id",  Ref#,      ["req"]),
      TagSpec("mod", DateTime#, ["req"]),

      // config tags
      TagSpec("dis",          Str#,    ["req", "summary"]),
      TagSpec("uri",          Uri#,    ["req", "summary"]),
      TagSpec("username",     Str#,    ["req"]),
      TagSpec("midcConn",  Marker#, ["req"]),

      // status tags
      TagSpec("disabled",     Str#, ["hidden"]),
      TagSpec("connStatus",   Str#, ["summary", "hidden"]),
      TagSpec("connState",    Str#, ["summary", "hidden"]),
      TagSpec("connErr",      Str#, ["summary", "hidden"]),
    ]
  }
}

