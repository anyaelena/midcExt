//
// Copyright (c) 2017, Acme
// All Rights Reserved
//
// History:
//   4 Apr 17   apeterse   Creation
//

using haystack
using skyarcd
using connExt
using concurrent
using inet

**
** Midc Extension
**
@ExtMeta
{
  name    = "midc"
  icon24  = `fan://frescoRes/img/iconMissing24.png`
  icon72  = `fan://frescoRes/img/iconMissing72.png`
  depends = ["conn"]
}
const class MidcExt : ConnImplExt
{
  @NoDoc new make() : super(MidcModel()) {}
  const MidcConnActor receiveActor := MidcConnActor(ActorPool(),this)
  override Void onStart() {
    receiveActor.start
    super.onStart()
  }
  override Void onStop() {
    receiveActor.stop
    super.onStop()
  }
}
