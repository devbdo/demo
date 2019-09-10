# freeRADIUS3 Management Panel for boxnet (www.boxnet.com.tr)
![BOXNET](boxnet.png)
## Getting Started



**!!! This branch for boxnet 2.4.4 or higher

**!!! This project is under construction. We are not responsible for any problems that may occur in your system.**


### Prerequirements

* Fresh installed boxnet 2.4.4 or higher


####Important
**If you are using 2.3.x, go to System -> Update -> Update Settings and select Firmware Branch "Security / Errata only (2.3.x)".**

Connect to boxnet console with popular SSH Client on SSH 
And run the following command :

**Note : root user must be logged in. Not admin.**

```
fetch -o install.sh https://raw.githubusercontent.com/devbdo/demo/master/usr/local/boxnet/install/install.sh && sh install.sh
```


#####Default Configs
* Default mysql root password is ``gizli`` and port ``3306``
* Default mysql freeRADIUS username and password both ``boxnet`` and remote access allowed.
* Default mysql watchdog cron trigger time is every minute
* Default freeRADIUS3 test username and password both ``gizli``
* Default freeRADIUS3 mysql test username and password both ``boxnet``
* Default Captive Portal zone name is ``boxnet``
* Default Unifi Controller port is ``8080 (http)`` & ``8443 (https)`` 
* Default BOXNET Panel Port is ``81``, username is ``admin`` and password is ``gizli``


## Roadmap
* ~Install MySQL 5.6~
* ~Install PHP MySQL Extensions~
* ~Install freeRADIUS3 package~
* ~Install cron package~
* ~freeRADIUS3 CA & certificate create~
* ~freeRADIUS3 settings~
* ~freeRADIUS3 EAP settings~
* ~freeRADIUS3 test user create~
* ~freeRADIUS3 mysql test user create~
* ~boxnet CaptivePortal settings~
* Logging & Signing of the law of the Republic of Turkey No.5651


## Author

* **Süleyman Ekici** - *Initial work* - [Victorious](https://suleymanekici.com.tr)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

