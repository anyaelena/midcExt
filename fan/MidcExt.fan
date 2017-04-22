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
  const ActorPool pool := ActorPool()
  // This is a hack that assumes we have exactly 2 connectors, on ports 50260 and 50160
  const MidcConnActor[] receiveActors := MidcConnActor[MidcConnActor(pool, this, 50160),MidcConnActor(pool, this, 50260)]
  override Void onStart() {
    // conns := this.proj.readAll("midcConn")
    // log.info("midcConn records: $conns.size")
    // conns.each |conn| {
    //   port := (Number)conn["port"]
    //   a := MidcConnActor(pool, this, port.toInt)
    //   receiveActors.add(a)
    // }
    // receiveActor.start
    receiveActors.each |a| {
      a.start
    }
    super.onStart()
  }
  override Void onStop() {
    receiveActors.each |a| {
      a.stop
    }
    super.onStop()
  }
}
