# snort3
This is my fork of Entware (which is a fork of OpenWrt) version of Snort 3.0.0 beta 4.  This has been tested only on my RT-AC86U and only designed to work
ONLY on the newer Merlin Asus HND routers (specifically RT-AC86U and RT-AX88U).  This snort3 has several dependencies, so rather than providing
all dependencies libraries in this release, the best way is to install the original snort classic (2.x series), then uninstall the classic and then
install the small subset of delta dependencies then install snort3 package at end of the dependency chain.

Snort 3 by default is a memory hog (pun intented), therefore will NOT run out of the box with its default configurations.  Careful tweaking is required to
limit the memory usage in order to have it run on embedded devices such as the Asus routers with 1 GB of memory or less.

Snort 3 is a GPL based IDS/IPS to similar to Suricata (another GPL IDS/IPS) and proprietary solutions (such as TrendMicro's AiProtect on Asus routers).
GPL based IDS/IPS is preferred by many, some may prefer to inspect the source code and see and understand how it performs Deep Packet Inspection (DPI) and
how it uses the rules sets to alert or block potential intrusions into your home network.  Because it's open source, new rules can be setup by users to
customize their own needs and requirements.

Getting this to work on an small embedded devices was a challenge, but I enjoyed the challenge and was able to make it workable on them.

Enjoy, have fun and keep GPL going!
