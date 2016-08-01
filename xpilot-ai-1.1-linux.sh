#! /bin/bash
# Evan Gray - 31 Oct 2012
# Install dependencies
#~ sudo apt-get install xutils-dev gcc make libx11-dev libxext-dev
# Download and compile XPilot
sudo apt-get install xutils-dev
mkdir xpilot-ai
wget http://xpilot-ai.org/downloads/xpilot-4.5.5.tar.bz2
tar xjf xpilot-4.5.5.tar.bz2
rm xpilot-4.5.5.tar.bz2
cd xpilot-4.5.5
echo;echo "Building and Installing XPilot. This may take a few minutes."
xmkmf -a
make CC='gcc -fPIC' --silent
# Relocate files
#cp -r share ../xpilot-ai/
#~ mv src/server/xpilots ../xpilot-ai/
mv src/client/xpilot ../xpilot-ai/
mv src/mapedit/xp-mapedit ../xpilot-ai/
mv src/replay/xp-replay ../xpilot-ai/
# Download and compile our alternate server
cd src/server/
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/globalAI.h
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/cmdlineAI.c
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/playerAI.c
gcc -fPIC -O -I../common/ -I../lib/ -Dlinux -D__amd64__ -D_POSIX_C_SOURCE=199309L -D_XOPEN_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -c -o playerAI.o playerAI.c
gcc -fPIC -O -I../common/ -I../lib/ -Dlinux -D__amd64__ -D_POSIX_C_SOURCE=199309L -D_XOPEN_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -c -o cmdlineAI.o cmdlineAI.c
gcc -fPIC -o xpilots -O alliance.o asteroid.o cannon.o cell.o cmdlineAI.o collision.o command.o contact.o event.o fileparser.o frame.o id.o item.o laser.o map.o metaserver.o netserver.o object.o objpos.o option.o parser.o play.o playerAI.o robot.o robotdef.o rules.o saudio.o sched.o score.o server.o ship.o shot.o showtime.o stratbot.o tuner.o update.o walls.o wildmap.o ../common/libxpcommon.a -lm
cd ../..
mv src/server/xpilots ../xpilot-ai
# Download and compile AI code
cd src/client/
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/clientAI.c
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/clientAI.h
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/defaultAI.c
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/paintdataAI.c
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/painthudAI.c
wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/xpilotAI.c
gcc -fPIC -O -I../common/ -I../../lib/ -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o clientAI.o clientAI.c
gcc -fPIC -O -I../common/ -I../../lib/ -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o defaultAI.o defaultAI.c
gcc -fPIC -O -I../common/ -I../../lib/ -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o paintdataAI.o paintdataAI.c
gcc -fPIC -O -I../common/ -I../../lib/ -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o painthudAI.o painthudAI.c
gcc -fPIC -O -I../common/ -I../../lib/ -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o xpilotAI.o xpilotAI.c

  sudo apt-get -y install python3-dev libice-dev libsm-dev
  wget http://xpilot-ai.org/downloads/xpilot-ai-1.1/pyAI.c
  gcc -fPIC -O -I../common/ -I../../lib/ -I/usr/include/python3.2 -I/usr/include/python3.3 -I/usr/include/python3.4 -Dlinux -D__i386__ -D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE -D_SVID_SOURCE -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DFUNCPROTO=15 -DNARROWPROTO -DWINDOWSCALING -c -o pyAI.o pyAI.c
  gcc -o libpyAI.so -fPIC -shared -Wl,-soname,libpyAI.so -O about.o blockbitmaps.o caudio.o clientAI.o colors.o configure.o datagram.o dbuff.o defaultAI.o gfx2d.o gfx3d.o guimap.o guiobjects.o join.o netclient.o paint.o paintdataAI.o painthudAI.o paintmap.o paintobjects.o paintradar.o query.o record.o sim.o syslimit.o talk.o talkmacros.o textinterface.o texture.o usleep.o welcome.o widget.o xeventhandlers.o xevent.o xinit.o pyAI.o xpilotAI.o xpmread.o ../common/libxpcommon.a -lX11 -lm
  mkdir ../../../xpilot-ai/python
  mv libpyAI.so ../../../xpilot-ai/python
 
    cd ../../../xpilot-ai/python
    wget http://xpilot-ai.org/downloads/example%20bots/Ambidextrous.py
    wget http://xpilot-ai.org/downloads/example%20bots/Helper.py
    wget http://xpilot-ai.org/downloads/example%20bots/Spinner.py
    wget http://xpilot-ai.org/downloads/example%20bots/TesterBot.py
    cd ../../xpilot-4.5.5/src/client


cd ../../..
rm -r xpilot-4.5.5
# Install Xpilot-AI maps
cd xpilot-ai
echo;echo "Installing maps!"
wget http://xpilot-ai.org/downloads/maps.tar.gz
tar xfz maps.tar.gz
rm maps.tar.gz

