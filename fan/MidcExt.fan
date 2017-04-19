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
  override Void onStart() {
    log.info("in onstart for midcExt")
    pool := ActorPool()
    // todo one actor for each midcConn rec (listen on different ports)
    a := Actor(pool) |->Obj?| {
      log.info("in receive for actor")
      socket := UdpSocket.make
      socket.bind(null,50260)  //todo dynamic port for each midcConn rec
      log.info("midc socket bound successfully")
      try {
        while (true) {
          packet := socket.receive //receive is blocking. packet is of type inet::UdpPacket
          // log.info("packet received. trying to make sense of it")
          // log.info("ip: " + packet.addr)
          // log.info("port: " + packet.port)      
          //send to actor for appropriate MidcConn (based on port?)
        }
        return null
      } finally {
        log.info("closing socket")
        socket.close // So we make sure the socket doesn't linger
      }
    }.send(null)
    return super.onStart()
  }
}
