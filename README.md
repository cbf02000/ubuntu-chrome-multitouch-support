Chrome Multitouch Support for Ubuntu + Dell P2714T (P2314T)
=============

This toolkit enables support for handling Dell P2714T multi-touch events in Ubuntu + Chrome.
It intercepts kernel touch events, broadcasts them through TUIO interface, and injects them into Javascript as standard touch events.

Installation
-------

Simply run:
``` sh
sudo ./setup.sh
```

This command would download all the dependencies, and install everything you need.

Once everything is installed, it reboot the system and initiate the processes. By default, the touch screen would emulate mouse events. There is a script to disable the function, which gets called everytime X is started. However, when you unplug/replug the USB interface, it would reinitiate the emulation. In that case, simply restart X.


Special Thanks
-----------------

This toolkit uses the following open-source software packages:

* mtdev2tuio (https://github.com/olivopaolo/mtdev2tuio)
* Caress (http://caressjs.com/)
