//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   apeterse   Creation
//

using haystack
using connExt

**
** MidcModel
**
@Js
const class MidcModel : ConnModel
{
  new make() : super(MidcModel#.pod)
  {
    connProto = Etc.makeDict([
      "dis": "Midc Conn",
      "midcConn": Marker.val,
      "username": "",
      "uri": `http://host/midc/`,
    ])
  }

  override const Dict connProto
  override Type? pointAddrType() { Str# }
  override Bool isPollingSupported() { false }
  override Bool isCurSupported() { true }
}

